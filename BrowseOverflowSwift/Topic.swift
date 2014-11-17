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
    
    private func sortQuestionsLatestFirst(questions: [Question]) -> [Question] {
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
    
    var recentQuestions: [Question] {
        return sortQuestionsLatestFirst(questions)
    }
    
    func addQuestion(question: Question) {
        var newQuestions = questions
        newQuestions.append(question)
        if (newQuestions.count > 20) {
            newQuestions = sortQuestionsLatestFirst(newQuestions)
            newQuestions = Array(newQuestions[Range(start: 0, end: 20)])
        }
        questions = newQuestions
    }
}
