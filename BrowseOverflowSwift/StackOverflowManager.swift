//
//  StackOverflowManager.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

class StackOverflowManager {
    weak var delegate: StackOverflowManagerDelegate?
    var communicator: StackOverflowCommunicator?
    
    init() {}
    
    func fetchQuestionsOnTopic(topic: Topic) {
        communicator?.searchForQuestionsWithTag(topic.tag)
    }
}