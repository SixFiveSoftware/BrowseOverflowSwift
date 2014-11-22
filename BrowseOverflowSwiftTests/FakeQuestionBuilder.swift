//
//  FakeQuestionBuilder.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/21/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class FakeQuestionBuilder: QuestionBuilder {
    var JSON: String = ""
    var arrayToReturn: [Question]!
    var errorToSet: NSError!
    
    override func questionsFromJSON(json: String) -> ([Question]!, NSError!) {
        self.JSON = json
        return (arrayToReturn, errorToSet)
    }
}