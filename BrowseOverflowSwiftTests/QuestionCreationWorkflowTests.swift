//
//  QuestionCreationTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class QuestionCreationWorkflowTests: XCTestCase {

    var manager: StackOverflowManager?
    var delegate: MockStackOverflowManagerDelegate?
    var underlyingError: NSError?
    var question: Question?
    var questionArray: [Question]?
    var questionBuilder: FakeQuestionBuilder?
    
    override func setUp() {
        super.setUp()
    
        manager = StackOverflowManager()
        delegate = MockStackOverflowManagerDelegate()
        manager?.delegate = delegate
        underlyingError = NSError(domain: "Test domain", code: 0, userInfo: nil)
        question = Question()
        questionArray = [Question]()
        questionBuilder = FakeQuestionBuilder()
    }
    
    override func tearDown() {
        manager = nil
        delegate = nil
        underlyingError = nil
        question = nil
        questionArray = nil
        questionBuilder = nil
        
        super.tearDown()
    }

    func testConformingObjectCanBeDelegate() {
        XCTAssertNotNil(manager!.delegate, "Object conforming to teh delegate protocol should be used as the delegate")
    }
    
    func testManagerAcceptsNilAsADelegate() {
        manager?.delegate = nil
        XCTAssertNil(manager?.delegate, "It should be acceptable to use nil as an object's delegate")
    }
    
    func testAskingForQuestionsMeansRequestingData() {
        let communicator = MockStackOverflowCommunicator()
        manager!.communicator = communicator
        let topic = Topic(name: "iPhone", tag: "iphone")
        manager!.fetchQuestionsOnTopic(topic)
        XCTAssertTrue(communicator.wasAskedToFetchQuestions, "The communicator should need to fetch data.")
    }
    
    func testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator() {
        let underlyingError = NSError(domain: "Test domain", code: 0, userInfo: nil)
        manager!.searchingForQuestionsFailedWithError(underlyingError)
        XCTAssertFalse(underlyingError == delegate!.fetchError, "Error should be at the correct level of abstraction")
    }
    
    func testErrorReturnedToDelegateDocumentsUnderlyingError() {
        let delegate = MockStackOverflowManagerDelegate()
        manager!.delegate = delegate
        let underlyingError = NSError(domain: "Test domain", code: 0, userInfo: nil)
        manager!.searchingForQuestionsFailedWithError(underlyingError)
        if let underlyingFetchError = delegate.fetchError?.userInfo?[NSUnderlyingErrorKey] as? NSError {
            XCTAssertEqual(underlyingFetchError, underlyingError, "The underlying error should be availalbe to client code")
        } else {
            XCTFail("Could not obtain underlying error")
        }
    }
    
    func testQuestionJSONIsPassedToQuestionBuilder() {
        manager!.questionBuilder = questionBuilder
        manager!.receivedQuestionsJSON("Fake JSON")
        XCTAssertEqual(questionBuilder!.JSON, "Fake JSON", "Downloaded JSON is sent to the builder")
        manager!.questionBuilder = nil
    }
    
    func testDelegateNotifiedOfErrorWhenQuestionBuilderFails() {
        questionBuilder!.arrayToReturn = nil
        questionBuilder!.errorToSet = underlyingError
        manager?.questionBuilder = questionBuilder
        manager?.receivedQuestionsJSON("Fake JSON")
        XCTAssertNotNil(delegate?.fetchError?.userInfo?[NSUnderlyingErrorKey], "the delegate should have found out about the error")
        manager?.questionBuilder = nil
    }
    
    func testDelegateNotToldAboutErrorWhenQuestionsReceived() {
        questionBuilder!.arrayToReturn = questionArray
        manager!.receivedQuestionsJSON("Fake JSON")
        XCTAssertNil(delegate!.fetchError, "No error should be received on success")
    }
    
    func testDelegateReceivesTheQuestionsDiscoveredByManager() {
        questionBuilder!.arrayToReturn = questionArray
        manager!.receivedQuestionsJSON("Fake JSON")
        if let receivedQuestions = delegate!.receivedQuestions {
            XCTAssertEqual(receivedQuestions, questionArray!, "The manager should have sent its questions to the delegate")
        }
    }

}
