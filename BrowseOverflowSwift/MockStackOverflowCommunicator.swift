//
//  MockStackOverflowCommunicator.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class MockStackOverflowCommunicator: StackOverflowCommunicator {
    private var _wasAskedToFetchQuestions = false
    private var _wasAskedToFetchBody = false
    
    var wasAskedToFetchQuestions: Bool {
        return _wasAskedToFetchQuestions
    }
    
    var wasAskedToFetchBody: Bool {
        return _wasAskedToFetchBody
    }
    
    override func searchForQuestionsWithTag(tag: String) {
        _wasAskedToFetchQuestions = true
    }
    
    override func searchForBodyForQuestionWithID(questionID: Int) {
        _wasAskedToFetchBody = true
    }
    
}