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
    
    init() {}
    
    func fetchQuestionsOnTopic(topic: Topic) {
        communicator?.searchForQuestionsWithTag(topic.tag)
    }
    
    func searchingForQuestionsFailedWithError(error: NSError) {
        let errorInfo = [NSUnderlyingErrorKey : error]
        let reportableError = NSError(domain: StackOverflowManagerSearchFailedError, code: StackOverflowManagerErrorQuestionCode.Search.rawValue, userInfo: errorInfo)
        delegate?.fetchingQuestionsOnTopic(nil, failedWithError: reportableError)
    }
}
