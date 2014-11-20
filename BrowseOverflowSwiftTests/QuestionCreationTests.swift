//
//  QuestionCreationTests.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import UIKit
import XCTest

class QuestionCreationTests: XCTestCase {

    var manager: StackOverflowManager?
    
    override func setUp() {
        super.setUp()
    
        manager = StackOverflowManager()
    }
    
    override func tearDown() {
        manager = nil
        
        super.tearDown()
    }

    /*   // test not really relevant in Swift
    func testNonConformingObjectCannotBeDelegate() {
        XCTAssertNotEqual(manager!.delegate, NSNull(), "NSNull shuold not be used as the delegate as it doesn't conform to the delegate protocol")
    }
    */

    func testConformingObjectCanBeDelegate() {
        let delegate = MockStackOverflowManagerDelegate()
        manager?.delegate = delegate
        XCTAssertNotNil(manager!.delegate, "Object conforming to teh delegate protocol should be used as the delegate")
    }
    
    func testManagerAcceptsNilAsADelegate() {
        manager?.delegate = nil
        XCTAssertNil(manager?.delegate, "It should be acceptable to use nil as an object's delegate")
    }
    
    func testAskingForQuestionsMeansRequestingData() {
        let communicator = MockStackOverflowCommunicator()
        manager!.communicator = communicator
        let topic = Topic(name: "iPhone", tag: "iphone")
        manager!.fetchQuestionsOnTopic(topic)
        XCTAssertTrue(communicator.wasAskedToFetchQuestions, "The communicator should need to fetch data.")
    }

}
