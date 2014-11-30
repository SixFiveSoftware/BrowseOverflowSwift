//
//  InspectableStackOverflowCommunicator.swift
//  BrowseOverflowSwift
//
//  Created by BJ Miller on 11/26/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

import Foundation

class InspectableStackOverflowCommunicator: StackOverflowCommunicator {

    private var _urlToFetch: NSURL?

    override var urlToFetch: NSURL? {
        return _urlToFetch
    }
    
    
}