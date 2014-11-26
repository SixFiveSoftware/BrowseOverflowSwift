//
//  StackOverflowManagerDelegate.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

protocol StackOverflowManagerDelegate: class {
    func fetchingQuestionsFailedWithError(error: NSError)
    func didReceiveQuestions(questions: [Question])
    func bodyReceivedForQuestion(question: Question!)
}
