//
//  MockStackOverflowManagerDelegate.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/20/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class MockStackOverflowManagerDelegate: StackOverflowManagerDelegate {
    
    var fetchError: NSError?
    
    init() {}
    
    func fetchingQuestionsOnTopic(topic: Topic?, failedWithError error: NSError) {
        fetchError = error
    }
}
