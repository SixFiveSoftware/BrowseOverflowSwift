//
//  Answer.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/18/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

struct Answer {
    var text = ""
    var person: Person?
    var score = 0
    var accepted = false
    
    init() {}
    
    func compare(otherAnswer: Answer) -> NSComparisonResult {
        if accepted && !otherAnswer.accepted {
            return .OrderedAscending
        } else if !accepted && otherAnswer.accepted {
            return .OrderedDescending
        }
        if score > otherAnswer.score {
            return .OrderedAscending
        } else if score < otherAnswer.score {
            return .OrderedDescending
        } else {
            return .OrderedSame
        }
    }
}
