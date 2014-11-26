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
    
    let questionJSON = "{\"items\": [{\"tags\": [\"iphone\",\"objective-c\",\"ios\",\"cocoa-touch\",\"reachability\"],\"owner\": {\"reputation\": 16904,\"user_id\": 40002,\"user_type\": \"registered\",\"accept_rate\": 96,\"profile_image\": \"https://www.gravatar.com/avatar/c521c11562c3540db79eca1cd632bd5e?s=128&d=identicon&r=PG\",\"display_name\": \"Brock Woolf\",\"link\": \"http://stackoverflow.com/users/40002/brock-woolf\"},\"is_answered\": true,\"view_count\": 260426,\"protected_date\": 1295863577,\"accepted_answer_id\": 3597085,\"answer_count\": 30,\"score\": 717,\"last_activity_date\": 1416556473,\"creation_date\": 1246783501,\"last_edit_date\": 1359578426,\"question_id\": 1083701,\"link\": \"http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk\",\"title\": \"How to check for an active Internet Connection on iPhone SDK?\"}]}"
    /*
    {
    "items": [
    {
    "tags": [
    "iphone",
    "objective-c",
    "ios",
    "cocoa-touch",
    "reachability"
    ],
    "owner": {
    "reputation": 16904,
    "user_id": 40002,
    "user_type": "registered",
    "accept_rate": 96,
    "profile_image": "https://www.gravatar.com/avatar/c521c11562c3540db79eca1cd632bd5e?s=128&d=identicon&r=PG",
    "display_name": "Brock Woolf",
    "link": "http://stackoverflow.com/users/40002/brock-woolf"
    },
    "is_answered": true,
    "view_count": 260426,
    "protected_date": 1295863577,
    "accepted_answer_id": 3597085,
    "answer_count": 30,
    "score": 717,
    "last_activity_date": 1416556473,
    "creation_date": 1246783501,
    "last_edit_date": 1359578426,
    "question_id": 1083701,
    "link": "http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk",
    "title": "How to check for an active Internet Connection on iPhone SDK?"
    }
*/

//    let questionDetailJSON = "{\"items\":[{\"tags\":[\"iphone\",\"objective-c\",\"ios\",\"cocoa-touch\",\"reachability\"],\"owner\":{\"reputation\":16909,\"user_id\":40002,\"user_type\":\"registered\",\"accept_rate\":96,\"profile_image\":\"https://www.gravatar.com/avatar/c521c11562c3540db79eca1cd632bd5e?s=128&d=identicon&r=PG\",\"display_name\":\"Brock Woolf\",\"link\":\"http://stackoverflow.com/users/40002/brock-woolf\"},\"is_answered\":true,\"view_count\":260481,\"protected_date\":1295863577,\"accepted_answer_id\":3597085,\"answer_count\":30,\"score\":718,\"last_activity_date\":1416556473,\"creation_date\":1246783501,\"last_edit_date\":1359578426,\"question_id\":1083701,\"link\":\"http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk\",\"title\":\"How to check for an active Internet Connection on iPhone SDK?\",\"body\":\"I would like to check to see if I have an Internet connection on the iPhone\"}],\"has_more\":false,\"quota_max\":10000,\"quota_remaining\":9969}"
    let questionDetailJSON = "{\"items\": [{\"body\": \"I would like to check to see if I have an Internet connection on the iPhone\"}]}"
/*
    {
    "items": [
    {
    "tags": [
    "iphone",
    "objective-c",
    "ios",
    "cocoa-touch",
    "reachability"
    ],
    "owner": {
    "reputation": 16909,
    "user_id": 40002,
    "user_type": "registered",
    "accept_rate": 96,
    "profile_image": "https://www.gravatar.com/avatar/c521c11562c3540db79eca1cd632bd5e?s=128&d=identicon&r=PG",
    "display_name": "Brock Woolf",
    "link": "http://stackoverflow.com/users/40002/brock-woolf"
    },
    "is_answered": true,
    "view_count": 260481,
    "protected_date": 1295863577,
    "accepted_answer_id": 3597085,
    "answer_count": 30,
    "score": 718,
    "last_activity_date": 1416556473,
    "creation_date": 1246783501,
    "last_edit_date": 1359578426,
    "question_id": 1083701,
    "link": "http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk",
    "title": "How to check for an active Internet Connection on iPhone SDK?",
    "body": "I would like to check to see if I have an Internet connection on the iPhone"
    }
    ],
    "has_more": false,
    "quota_max": 10000,
    "quota_remaining": 9969
    }
    
    */
    var questionBuilder: QuestionBuilder?
    var question: Question?
    let noQuestionsJSONString = "{\"noquestions\":true}"
    let stringIsNotJSON = "this is not JSON"

    override func setUp() {
        questionBuilder = QuestionBuilder()
        question = questionBuilder!.questionsFromJSON(questionJSON).0[0]
    }
    
    override func tearDown() {
        questionBuilder = nil
        question = nil
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
    
    func testRealJSONWithoutQuestionsArrayIsError() {
        let jsonString = "{ \"noquestions\": true }"
        let (questions, error) = questionBuilder!.questionsFromJSON(jsonString)
        if error != nil {
            XCTAssertEqual(error.code, QuestionBuilderError.MissingData.rawValue, "This case should not be an invalid JSON error")
        }
    }
    
    func testJSONWithOneQuestionReturnsOneQuestionObject() {
        let (questions, error) = questionBuilder!.questionsFromJSON(questionJSON)
        if questions != nil {
            XCTAssertEqual(questions!.count , 1, "The builder should have created a question")
        } else {
            XCTFail("Builder could not build a Question from JSON")
        }
    }
    
    func testQuestionCreatedFromJSONHasPropertiesPresentedInJSON() {
        XCTAssertEqual(question!.questionID, 1083701, "The Question ID should match the data we sent")
        XCTAssertEqual(question!.date.timeIntervalSince1970, 1246783501, "The date of the question should match the data we sent.")
        XCTAssertEqual(question!.title, "How to check for an active Internet Connection on iPhone SDK?", "The title should matcht the provided data")
        XCTAssertEqual(question!.score, 717, "Score should match the data we sent")
        let asker = question!.asker
        XCTAssertEqual(asker.name, "Brock Woolf", "Brock Woolf should have asked this question")
        XCTAssertEqual(asker.avatarURL?.absoluteString ?? "", "https://www.gravatar.com/avatar/c521c11562c3540db79eca1cd632bd5e?s=128&d=identicon&r=PG", "The avatar URL should be baesd on the supplied email hash")
    }
    
    func testQuestionCreatedFromEmptyObjectIsStillValidObject() {
        let emptyQuestion = "{ \"items\": [ {} ] }"
        let (questions, error) = questionBuilder!.questionsFromJSON(emptyQuestion)
        if questions != nil {
            XCTAssertEqual(questions!.count, 1, "QuestionBuilder must handle partial input")
        } else {
            XCTFail("Did not receive one question from empty question JSON")
        }
    }
    
    func testBuildingQuestionBodyWithNoDataCannotBeTried() {
        let (_, error) = questionBuilder!.fillInDetailsForQuestion(question!, fromJSON: nil)
        if error != nil {
            XCTAssertEqual(error.localizedDescription, "Not receiving data should have been handled earlier", "Not receiving data should have been handled earlier")
        } else {
            XCTFail("Should have received an error for sending nil JSON to fill question body")
        }
    }
    
    /*  // test may be irrelevant since Swift's strong typing requires non-nil param
    func testBuildingQuestionBodyWithNoQuestionCannotBeTried() {
        if let error = questionBuilder!.fillInDetailsForQuestion(nil, fromJSON: questionDetailJSON) {
            XCTAssertEqual(error.localizedDescription, "No reason to expect that a nil question is passed", "No reason to expect that a nil question is passed")
        } else {
            XCTFail("Question should not be nil")
        }
    }
    */

    func testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion() {
        questionBuilder!.fillInDetailsForQuestion(question!, fromJSON: stringIsNotJSON)
        XCTAssertNil(question!.body, "Body should not have been added")
    }
    
    func testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded() {
        questionBuilder!.fillInDetailsForQuestion(question!, fromJSON: noQuestionsJSONString)
        XCTAssertNil(question!.body, "There was no body to add")
    }
    
    func testBodyContainedInJSONIsAddedToQuestion() {
        questionBuilder!.fillInDetailsForQuestion(question!, fromJSON: questionDetailJSON)
        XCTAssertEqual(question!.body, "I would like to check to see if I have an Internet connection on the iPhone")
    }
    
    

}
