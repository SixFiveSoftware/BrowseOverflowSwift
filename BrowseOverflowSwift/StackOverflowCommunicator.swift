//
//  StackOverflowCommunicator.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class StackOverflowCommunicator {
    
    typealias SearchAPICompletion = (NSHTTPURLResponse!) -> ()
    
    private var _urlToFetch: NSURL?
    var urlToFetch: NSURL? {
        return _urlToFetch
    }
    
    var sharedSession: NSURLSession?
    
    init () {}
    
    private func fetchContentAtURL(url: NSURL, completion: SearchAPICompletion!) {
        _urlToFetch = url
        
        if sharedSession == nil {
            sharedSession = NSURLSession.sharedSession()
        }
        
        sharedSession?.resetWithCompletionHandler
        
        let task = sharedSession!.dataTaskWithURL(urlToFetch!, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                if completion != nil { completion!(httpResponse) }
            } else {
                if completion != nil { completion!(nil) }
            }
        })
        
        task.resume()
    }
    
    func searchForQuestionsWithTag(tag: String, completion: SearchAPICompletion? = nil) {
        fetchContentAtURL(NSURL(string: "https://api.stackexchange.com/2.2/tags/\(tag)/faq?site=stackoverflow")!, completion: completion)
        
    }
    
    func searchForBodyForQuestionWithID(questionID: Int) {
    }
    
    func downloadInformationForQuestionWithID(identifier: Int) {
        fetchContentAtURL(NSURL(string: "https://api.stackexchange.com/2.2/questions/12345?order=desc&sort=activity&site=stackoverflow&filter=!9YdnSJ*_S")!, completion: nil)
    }
    
    func downloadAnswersToQuestionWithID(identifier: Int) {
        
    }
    
    func fetchBodyForQuestionWithID(identifier: Int) {
        
    }
}