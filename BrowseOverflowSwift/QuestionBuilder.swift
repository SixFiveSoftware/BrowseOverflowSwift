//
//  QuestionBuilder.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/21/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class QuestionBuilder {
    func questionsFromJSON(json: String!) -> ([Question]!, NSError!) {
        if (json == nil) {
            let error = NSError(domain: "Test Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Lack of data should have been handled elsewhere"])
            return (nil, error)
        }
        
        var localError : NSError?
        let questionData = json.dataUsingEncoding(NSUTF8StringEncoding)!
        var questionsJSON: AnyObject? = NSJSONSerialization.JSONObjectWithData(questionData, options: NSJSONReadingOptions.AllowFragments, error: &localError)
        
        if questionsJSON == nil {
            let error = NSError(domain: "Test Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON sent to QuestionBuilder"])
            
            return (nil, error)
        }
        return (nil, nil)
    }
}



//            if let unwrappedJSON = questionsJSON {
//                let JSONDictionary: [Dictionary] = unwrappedJSON as Array
//            }
//            if (questionsJSON?.isKindOfClass(NSDictionary) || questionsJSON?.isKindOfClass(NSArray)) {
//
//            }
// }
//        if (json == "Not JSON") {
//            let error = NSError(domain: "Test Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON sent to QuestionBuilder"])
//            return (nil, error)
//        }