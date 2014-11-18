//
//  Question.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class Question {
    var date = NSDate()
    var title = ""
    var score = 0
    
    private var _answerSet = NSMutableSet()
    
    var answers: [Answer] {
        let _answers = _answerSet.allObjects as [Answer]
        return _answers.sorted { (a1: Answer, a2: Answer) in
            let result = a2.compare(a1)
            switch result {
            case .OrderedDescending:
                return true
            default:
                return false
            }
        }
    }
    
    func addAnswer(answer: Answer) {
        _answerSet.addObject(answer)
    }
}
