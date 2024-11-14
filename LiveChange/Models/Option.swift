//
//  Option.swift
//  LiveChange
//
//  Created by YOUZONGYAN on 2024/11/1.
//

import Foundation

struct Option: Codable, Identifiable, Hashable {
    var id = UUID().uuidString
    var count: Int
    var name: String
}
