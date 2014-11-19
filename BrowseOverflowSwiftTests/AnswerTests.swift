//
//  AnswerTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/18/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class AnswerTests: XCTestCase {

    var answer: Answer!
    var otherAnswer: Answer!

    override func setUp() {
        super.setUp()
        
        answer = Answer()
        answer.text = "The answer is 42"
        answer.person = Person(name: "Graham Lee", avatarLocation: "http://example.com/avatar.png")
        answer.score = 42
        otherAnswer = Answer()
        otherAnswer.text = "I have the answer you need"
        otherAnswer.score = 42
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAnswerHasSomeText() {
        XCTAssertEqual(answer.text, "The answer is 42", "Answers need to contain some text")
    }
    
    func testSomeoneProvidedTheAnswer() {
        XCTAssertNotNil(answer.person, "A Person gave this Answer")
    }
    
    func testAnswersNotAcceptedByDefault() {
        XCTAssertFalse(answer.accepted, "Answer not accepted by default")
    }
    
    func testAnswerCanBeAccepted() {
        answer.accepted = true
        XCTAssertTrue(answer.accepted, "It is possible to accept an answer")
    }
    
    func testAnswerHasAScore() {
        XCTAssertTrue(answer.score == 42, "Answer's score can be retrieved")
    }
    
    func testAcceptedAnswerComesBeforeUnaccepted() {
        otherAnswer.accepted = true
        otherAnswer.score = answer.score + 10
        
        XCTAssertTrue(otherAnswer < answer, "Accepted answer should come first")
        XCTAssertTrue(answer > otherAnswer, "Unaccepted answer should come last")
    }
    
    func testAnswersWithEqualScoresCompareEqually() {
        XCTAssertEqual(answer, otherAnswer, "answers with equal scores should compare equally")
        XCTAssertEqual(otherAnswer, answer, "answers with equal scores should compare equally")
    }

    func testLowerScoringAnswerComesAfterHigher() {
        otherAnswer.score = answer.score + 10
        XCTAssertLessThan(otherAnswer, answer, "Higher score should come first")
        XCTAssertGreaterThan(answer, otherAnswer, "Lower score should come last")
    }
    
    func testFailure() {
        XCTFail("FAIL!!!")
    }
    
}
