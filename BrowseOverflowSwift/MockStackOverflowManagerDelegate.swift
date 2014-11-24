//
//  MockStackOverflowManagerDelegate.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class MockStackOverflowManagerDelegate: StackOverflowManagerDelegate {
    
    var fetchError: NSError?
    var receivedQuestions: [Question]?
    var bodyQuestion: Question?
    
    init() {}
    
    func fetchingQuestionsFailedWithError(error: NSError) {
        fetchError = error
    }
    
    func didReceiveQuestions(questions: [Question]) {
        receivedQuestions = questions
    }
    
    func bodyReceivedForQuestion(question: Question!) {
        bodyQuestion = question
    }
}
