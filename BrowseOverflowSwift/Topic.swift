//
//  Topic.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class Topic {
    let name: String
    let tag: String
    private var questions: [Question]
    
    init(name: String, tag: String) {
        self.name = name
        self.tag = tag
        self.questions = [Question]()
    }
    
    var recentQuestions: [Question] {
        let sortedQuestions = questions.sorted { (q1: Question, q2: Question) in
            let result = q2.date.compare(q1.date)
            switch result {
            case .OrderedDescending:
                return false
            default:
                return true
            }
        }
        return sortedQuestions
    }
    
    func addQuestion(question: Question) {
        questions.append(question)
    }
}
