//
//  QuestionBuilder.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/21/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

let QuestionBuilderErrorDomain = "QuestionBuilderErrorDomain"

enum QuestionBuilderError: Int {
    case InvalidJSON, MissingData
}

class QuestionBuilder {
    func questionsFromJSON(json: String!) -> ([Question]!, NSError!) {
        if json == nil {
            let error = NSError(domain: "Test Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Lack of data should have been handled elsewhere"])
            return (nil, error)
        }
        
        var localError : NSError?
        let questionData = json.dataUsingEncoding(NSUTF8StringEncoding)!
        var questionsJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(questionData, options: NSJSONReadingOptions.AllowFragments, error: &localError)
        
        if questionsJSON == nil {
            let error = NSError(domain: QuestionBuilderErrorDomain, code: QuestionBuilderError.InvalidJSON.rawValue, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON sent to QuestionBuilder"])
            
            return (nil, error)
        }
        
        if let questions: AnyObject = questionsJSON {
            var returnQuestions = [Question]()
            for question in parseQuestions(questions) {
                returnQuestions.append(question)
            }
            return (returnQuestions, nil)
        } else {
            let error = NSError(domain: QuestionBuilderErrorDomain, code: QuestionBuilderError.MissingData.rawValue, userInfo: [NSLocalizedDescriptionKey : "JSON Missing data"])
            return (nil, error)
        }
    }
    
    private func parseQuestions(questions: AnyObject) -> [Question] {
        var questionsToReturn = [Question]()
        
        println("questions: \(questions)")
        
        if let items = questions["items"] as? [[String : AnyObject]] {
            for item in items {
                // item is a dictionary. use keys
                let newQuestion = parseQuestion(item)
                questionsToReturn.append(newQuestion)
            }
        }
        
        return questionsToReturn
    }
    
    func parseQuestion(dict: [String : AnyObject]) -> Question {
            let question = Question()
            
            if let dateNum = dict["creation_date"] as? NSNumber {
                question.date = NSDate(timeIntervalSince1970: NSTimeInterval(dateNum.integerValue))
            }
            
            if let title = dict["title"] as? NSString {
                question.title = title
            }
            
            if let scoreNum = dict["score"] as? NSNumber {
                question.score = scoreNum.integerValue
            }
            
            if let questionIDNum = dict["question_id"] as? NSNumber {
                question.questionID = questionIDNum.integerValue
            }
            
            if question.asker == nil {
                if let owner = dict["owner"] as? [String: AnyObject] {
                    var _askerName = "", _askerAvatarUrl = ""
                    if let askerName = owner["display_name"] as? NSString {
                        _askerName = askerName
                    }
                    if let askerAvatarUrl = owner["profile_image"] as? NSString {
                        _askerAvatarUrl = askerAvatarUrl
                    }
                    question.asker = Person(name: _askerName, avatarLocation: _askerAvatarUrl)
                }
            }
            
            if let body = dict["body"] as? NSString {
                question.body = body
            }
            
            return question
    }
    
    func fillInDetailsForQuestion(question: Question!, fromJSON json: String!) -> (Question!, NSError!) {
        if json == nil {
            let error = NSError(domain: QuestionBuilderErrorDomain, code: QuestionBuilderError.InvalidJSON.rawValue, userInfo: [NSLocalizedDescriptionKey : "Not receiving data should have been handled earlier"])
            return (question, error)
        }
        
        var localError : NSError?
        let questionData = json.dataUsingEncoding(NSUTF8StringEncoding)!
        var questionJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(questionData, options: NSJSONReadingOptions.AllowFragments, error: &localError)
        
        if questionJSON == nil {
            let error = NSError(domain: QuestionBuilderErrorDomain, code: QuestionBuilderError.InvalidJSON.rawValue, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON sent to QuestionBuilder"])
            
            return (question, error)
        }
        
        println("questionJSON: \(questionJSON)")
        
        let questions = parseQuestions(questionJSON!)
        if !questions.isEmpty {
            question.body = questions[0].body
        }
        return (question, nil)
    }
}


