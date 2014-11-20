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
    
    var wasAskedToFetchQuestions: Bool {
        return _wasAskedToFetchQuestions
    }
    
    override func searchForQuestionsWithTag(tag: String) {
        _wasAskedToFetchQuestions = true
    }
    
}