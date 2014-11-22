//
//  QuestionBuilderTests.swift
//  BrowseOverflowSwift
//
//  Created by Hank Turowski on 11/22/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class QuestionBuilderTests: XCTestCase {
    var questionBuilder: QuestionBuilder?

    override func setUp() {
        questionBuilder = QuestionBuilder()
    }
    
    override func tearDown() {
        questionBuilder = nil
    }
    
    func testThatNilIsNotAnAcceptableParameter() {
        let (questions, error) = questionBuilder!.questionsFromJSON(nil)
        let errorMessage = "Lack of data should have been handled elsewhere"
        XCTAssertNil(questions)
        if let returnedError = error {
            XCTAssertEqual(errorMessage, returnedError.localizedDescription)
        }
        else {
            XCTFail("Returned nil error")
        }
    }
    
    func testNilReturnedWhenStringIsNotJSON() {
        let (questions, error) = questionBuilder!.questionsFromJSON("Not JSON")
        let errorMessage = "Invalid JSON sent to QuestionBuilder"
        XCTAssertNil(questions)
        if let returnedError = error {
            XCTAssertEqual(errorMessage, returnedError.localizedDescription)
        }
        else {
            XCTFail("Returned nil error")
        }
    }
    
}
