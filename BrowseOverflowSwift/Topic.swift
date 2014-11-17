//
//  Topic.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

class Topic {
    let name: String
    let tag: String
    
    init(name: String, tag: String) {
        self.name = name
        self.tag = tag
    }
    
    var recentQuestions: [Question] {
        return [Question]()
    }
}
