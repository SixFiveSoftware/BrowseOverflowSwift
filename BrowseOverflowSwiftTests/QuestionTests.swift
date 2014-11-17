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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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

}
