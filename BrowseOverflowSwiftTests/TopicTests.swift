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
    
    func testForInitiallyEmptyQuestionsList() {
        XCTAssertEqual(topic.recentQuestions.count, 0, "No questions added yet, count should be zero")
    }
    
    func testAddingAQuestionToTheList() {
        let question = Question()
        topic.addQuestion(question)
        XCTAssertEqual(topic.recentQuestions.count, 1, "Add a question and the count of questions should go up")
    }
    
    func testQuestionsAreListedChronologically() {
        let question1 = Question()
        question1.date = NSDate.distantPast() as NSDate
        
        let question2 = Question()
        question2.date = NSDate.distantFuture() as NSDate
        
        topic.addQuestion(question1)
        topic.addQuestion(question2)
        
        let questions = topic.recentQuestions
        let listedFirst: Question = questions[0]
        let listedSecond: Question = questions[1]
        
        XCTAssertEqual(listedFirst.date.laterDate(listedSecond.date), listedFirst.date, "The later question should appear first in the list")
    }
}
