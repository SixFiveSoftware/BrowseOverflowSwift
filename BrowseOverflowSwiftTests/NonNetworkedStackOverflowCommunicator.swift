//
//  NonNetworkedStackOverflowCommunicator.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/28/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class NonNetworkedStackOverflowCommunicator: StackOverflowCommunicator {
    var receivedData: NSData?
    var tag: String!
    weak var delegate: MockStackOverflowManager?
    
    override func searchForQuestionsWithTag(tag: String, completion: SearchAPICompletion? = nil) {
        self.tag = tag
    }
    
    func connection(connection: NSURLSession?, didReceiveResponse response: FakeURLResponse?) {
        receivedData = nil
        if let code = response?.statusCode {
            delegate!.topicFailureErrorCode = (code == 200) ? 0 : code
        }
    }
    
    func connection(connection: NSURLSession?, didFailWithError error: NSError) {
        delegate?.topicFailureErrorCode = error.code
    }
    
    func connectionDidFinishLoading(someData: String?) {
        delegate?.topicSearchString = NSString(data: receivedData!, encoding: NSUTF8StringEncoding) as String
    }
    
}