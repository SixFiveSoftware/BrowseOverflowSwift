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
        let _sorted = _answers.sorted(<)
        for (i, answer) in enumerate(_answers) {
            println("answer:\(i) -- score:\(answer.score), accepted:\(answer.accepted)")
        }
        return _answers.sorted(<)
    }
    
    func addAnswer(answer: Answer) {
        _answerSet.addObject(answer)
    }
}
