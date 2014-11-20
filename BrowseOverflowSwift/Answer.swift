//
//  Answer.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/18/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class Answer: Comparable {
    var text = ""
    var person: Person!
    var score = 0
    var accepted = false
    
    init() {}
}

func ==(lhs: Answer, rhs: Answer) -> Bool {
    return lhs.score == rhs.score && lhs.accepted == rhs.accepted
}

func <(lhs: Answer, rhs: Answer) -> Bool {
    if lhs.accepted && !rhs.accepted {
        return true
    } else if !lhs.accepted && rhs.accepted {
        return false
    }
    
    return lhs.score > rhs.score
}

func >(lhs: Answer, rhs: Answer) -> Bool {
    if lhs.accepted && !rhs.accepted {
        return false
    } else if !lhs.accepted && rhs.accepted {
        return true
    }
    
    return lhs.score < rhs.score
}
