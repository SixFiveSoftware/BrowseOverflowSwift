//
//  TopicTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class TopicTests: XCTestCase {

    var topic: Topic!
    
    override func setUp() {
        super.setUp()
        
        topic = Topic(name: "iPhone", tag: "iphone")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatTopicExists() {
        XCTAssertNotNil(topic, "should be able to create a Topic")
    }

    func testThatTopicCanBeNamed() {
        XCTAssertEqual(topic.name, "iPhone", "the Topic should have the name I gave it.")
    }
    
    func testThatTopicHasATag() {
        XCTAssertEqual(topic.tag, "iphone", "Topics need to have tags")
    }
    
    /*
    func testForAListOfQuestions() {
        XCTAssertTrue(topic.recentQuestions is [Question], "Topics should provide a list of recent questions")
    }
    */  // this test doesn't make sense in Swift since it is stronly typed to return [Question]
}
