//
//  StackOverflowManager.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

let StackOverflowManagerSearchFailedError = "StackOverflowManagerError"

enum StackOverflowManagerErrorQuestionCode : Int {
    case Search
}

class StackOverflowManager {
    weak var delegate: StackOverflowManagerDelegate?
    var communicator: StackOverflowCommunicator?
    var questionBuilder: QuestionBuilder?
    var questionNeedingBody: Question?
    
    init() {}
    
    func fetchQuestionsOnTopic(topic: Topic) {
        communicator?.searchForQuestionsWithTag(topic.tag)
    }
    
    private func tellDelegateAboutQuestionSearchError(errorInfo: [NSObject : NSError]!) {
        let reportableError = NSError(domain: StackOverflowManagerSearchFailedError, code: StackOverflowManagerErrorQuestionCode.Search.rawValue, userInfo: errorInfo)
        delegate?.fetchingQuestionsFailedWithError(reportableError)
    }
    
    func searchingForQuestionsFailedWithError(error: NSError) {
        let errorInfo = [NSUnderlyingErrorKey : error]
        tellDelegateAboutQuestionSearchError(errorInfo)
    }
    
    func receivedQuestionsJSON(objectNotation: String) {
        if questionBuilder != nil {
            let (questions, error) = questionBuilder!.questionsFromJSON(objectNotation)
            if questions == nil {
                var errorInfo: [NSObject : NSError]!
                if error != nil {
                    errorInfo = [NSUnderlyingErrorKey : error]
                }
                tellDelegateAboutQuestionSearchError(errorInfo)
            } else {
                delegate?.didReceiveQuestions(questions)
            }
        }
    }
    
    func fetchBodyForQuestion(question: Question) {
        questionNeedingBody = question
        communicator?.searchForBodyForQuestionWithID(question.questionID)
    }
    
    func fetchQuestionBodyFailedWithError(error: NSError) {
        let errorInfo = [NSUnderlyingErrorKey : error]
        tellDelegateAboutQuestionSearchError(errorInfo)
    }
    
    func receivedQuestionBodyJSON(json: String) {
        if questionBuilder == nil { return }
        
        questionBuilder!.fillInDetailsForQuestion(questionNeedingBody, fromJSON: json)
        delegate?.bodyReceivedForQuestion(questionNeedingBody)
        questionNeedingBody = nil
    }
}
