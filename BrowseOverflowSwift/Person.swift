//
//  Person.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class Person: Equatable {
    let name: String
    let avatarURL: NSURL?
    
    init(name: String, avatarLocation: String) {
        self.name = name
        self.avatarURL = NSURL(string: avatarLocation)
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    /*
    if let lefturl = lhs.avatarURL?.absoluteString {
        if let righturl = rhs.avatarURL?.absoluteString {
            return lhs.name == rhs.name && lefturl == righturl
        }
    }
    return false
    */
    return lhs.name == rhs.name && lhs.avatarURL?.absoluteString == rhs.avatarURL?.absoluteString
}
