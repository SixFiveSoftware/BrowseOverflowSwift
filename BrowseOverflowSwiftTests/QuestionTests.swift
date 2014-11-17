//
//  QuestionTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/17/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class QuestionTests: XCTestCase {

    var question: Question!

    override func setUp() {
        super.setUp()
        
        question = Question()
        question.date = NSDate.distantPast() as NSDate
        question.title = "Do iPhones also dream of electric sheep?"
        question.score = 42
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testQuestionHasADate() {
        let question = Question()
        let testDate = NSDate.distantPast() as NSDate
        question.date = testDate
        XCTAssertEqual(question.date, testDate, "Question needs to provide its date")
    }
    
    func testQuestionKeepsScore() {
        XCTAssertEqual(question.score, 42, "Quesiton needs to have a numeric score")
    }
    
    func testQuestionHasATitle() {
        XCTAssertEqual(question.title, "Do iPhones also dream of electric sheep?", "Question should know its title")
    }

}
