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
    var lowScore: Answer!
    var highScore: Answer!
    var asker: Person?

    override func setUp() {
        super.setUp()
        
        question = Question()
        question.date = NSDate.distantPast() as NSDate
        question.title = "Do iPhones also dream of electric sheep?"
        question.score = 42
        
        var accepted = Answer()
        accepted.score = 1
        accepted.accepted = true
        question.addAnswer(accepted)
        
        lowScore = Answer()
        lowScore.score = -4
        question.addAnswer(lowScore)
        
        highScore = Answer()
        highScore.score = 4
        question.addAnswer(highScore)
        
        asker = Person(name: "Graham Lee", avatarLocation: "http://www.example.com/avatar.png")
        question!.asker = asker
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
    
    func testQuestionCanHaveAnswersAdded() {
        let myAnswer = Answer()
        let currentAnswerCount = question.answers.count
        question.addAnswer(myAnswer)
        XCTAssertEqual(question.answers.count, currentAnswerCount + 1, "Must be able to add answers")
    }
    
    func testAcceptedAnswerIsFirst() {
        let firstAnswer = question.answers[0]
        let isAccepted = firstAnswer.accepted
        XCTAssertTrue(isAccepted, "Accepted answer comes first")
    }
    
    func testHighScoreAnswerBeforeLow() {
        let answers = question.answers
        let highIndex = find(answers, highScore)!
        let lowIndex = find(answers, lowScore)!
        XCTAssertTrue(highIndex < lowIndex, "High-scoring answer comes first")
    }
    
    func testQuestionHasAnID() {
        let questionID = 1234
        question!.questionID = questionID
        XCTAssertEqual(question!.questionID, questionID, "Question should have a unique ID from web API")
    }

    func testQuestionWasAskedBySomeone() {
        XCTAssertEqual(question!.asker, asker!, "Question should be asked by someone")
    }
}
