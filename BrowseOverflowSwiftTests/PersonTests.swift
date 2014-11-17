//
//  PersonTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class PersonTests: XCTestCase {

    var person: Person!

    override func setUp() {
        super.setUp()
        
        person = Person(name: "Graham Lee", avatarLocation: "http://example.com/avatar.png")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatPersonHasTheRightName() {
        XCTAssertEqual(person.name, "Graham Lee", "expecting a person to provide its name")
    }
    
    func testThatPersonHasAnAvatarURL() {
        if let url = person.avatarURL?.absoluteString {
            XCTAssertEqual(url, "http://example.com/avatar.png", "The Person's avatar should be represented by a URL")
        } else {
            XCTFail("Person's Avatar URL is poorly formed")
        }
    }

}
