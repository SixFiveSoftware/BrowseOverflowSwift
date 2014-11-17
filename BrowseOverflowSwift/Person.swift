//
//  Person.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class Person {
    let name: String
    let avatarURL: NSURL?
    
    init(name: String, avatarLocation: String) {
        self.name = name
        self.avatarURL = NSURL(string: avatarLocation)
    }
}
