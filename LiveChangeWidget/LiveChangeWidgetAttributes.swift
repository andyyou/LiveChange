//
//  LiveChangeWidgetAttributes.swift
//  LiveChange
//
//  Created by YOUZONGYAN on 2024/11/4.
//

import ActivityKit
import Foundation

struct LiveChangeWidgetAttributes: ActivityAttributes {
    
    typealias ContentState = Poll
    
    public var pollId: String
    init(pollId: String) {
        self.pollId = pollId
    }
}
