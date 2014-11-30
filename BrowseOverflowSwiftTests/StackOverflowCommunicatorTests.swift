//
//  StackOverflowCommunicatorTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/26/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class StackOverflowCommunicatorTests: XCTestCase {

    var communicator: StackOverflowCommunicator?
    var nnCommunicator: NonNetworkedStackOverflowCommunicator?
    var manager: MockStackOverflowManager?
    var fourOhFourResponse: FakeURLResponse?
    var receivedData: NSData?

    override func setUp() {
        super.setUp()
    
        communicator = StackOverflowCommunicator()
        nnCommunicator = NonNetworkedStackOverflowCommunicator()
        manager = MockStackOverflowManager()
        nnCommunicator!.delegate = manager
        fourOhFourResponse = FakeURLResponse(statusCode: 404)
        receivedData = "Result".dataUsingEncoding(NSUTF8StringEncoding)
    }
    
    override func tearDown() {
        communicator = nil
        nnCommunicator = nil
        manager = nil
        fourOhFourResponse = nil
        receivedData = nil
        
        super.tearDown()
    }

    func testSearchingForQuestionsOnTopicCallsTopicAPI() {
        let communicator = StackOverflowCommunicator()
        communicator.searchForQuestionsWithTag("ios")
        XCTAssertEqual(communicator.urlToFetch!.absoluteString!, "https://api.stackexchange.com/2.2/tags/ios/faq?site=stackoverflow", "Use the search API to find questions with a particular tag")
    }

    func testFillingInQuestionBodyCallsQuestionAPI() {
        communicator?.downloadInformationForQuestionWithID(12345)
        XCTAssertEqual(communicator!.urlToFetch!.absoluteString!, "https://api.stackexchange.com/2.2/questions/12345?order=desc&sort=activity&site=stackoverflow&filter=!9YdnSJ*_S", "Use the question body API to get the body for a question")
    }
    
    func testSearchingForQuestionsCreatesURLConnection() {
    
        let expectation = expectationWithDescription("test searching for questions creates url connection")
        
        communicator?.searchForQuestionsWithTag("ios") { httpResponse in
            expectation.fulfill()
            if httpResponse != nil {
                XCTAssertEqual(httpResponse.statusCode, 200, "HTTP response should be 200")
            } else {
                XCTFail("httpResponse was nil")
            }
        }
        
        waitForExpectationsWithTimeout(5.0, handler: { (error) -> Void in
            self.communicator!.sharedSession!.resetWithCompletionHandler({})
        })
    }
    
    func testReceivingResponseDiscardsExistingData() {
        nnCommunicator!.receivedData = "Hello".dataUsingEncoding(NSUTF8StringEncoding)
        nnCommunicator!.searchForQuestionsWithTag("ios")
        nnCommunicator!.connection(nil, didReceiveResponse: nil)
        XCTAssertNil(nnCommunicator!.receivedData, "Data shoudl have been discarded")
    }
    
    func testReceivingResponseWith404StatusPassesErrorToDelegate() {
        nnCommunicator!.searchForQuestionsWithTag("ios")
        nnCommunicator!.connection(nil, didReceiveResponse: fourOhFourResponse)
        XCTAssertEqual(manager!.topicFailureErrorCode ?? 0, 404, "Fetch failure was passed through to delegate")
    }
    
    func testNoErrorReceivedOn200Status() {
        let twoHundredResponse = FakeURLResponse(statusCode: 200)
        nnCommunicator!.searchForQuestionsWithTag("ios")
        nnCommunicator!.connection(nil, didReceiveResponse: twoHundredResponse)
        XCTAssertNotEqual(manager!.topicFailureErrorCode ?? 200, 200, "No need for error on 200 response")
    }
    
    func testConnectionFailingPassesErrorToDelegate() {
        nnCommunicator!.searchForQuestionsWithTag("ios")
        let error = NSError(domain: "Fake domain", code: 12345, userInfo: nil)
        nnCommunicator!.connection(nil, didFailWithError: error)
        XCTAssertEqual(manager!.topicFailureErrorCode ?? 0, 12345, "Failure to connect should get passed to the delegate")
    }
    
    func testSuccessfulQuestionSearchPassesDataToDelegate() {
        nnCommunicator!.searchForQuestionsWithTag("ios")
        nnCommunicator!.receivedData = receivedData
        nnCommunicator!.connectionDidFinishLoading(nil)
        XCTAssertEqual(manager!.topicSearchString ?? "", "Result", "The delegate should have received data on success")
    }

}
