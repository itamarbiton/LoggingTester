//
//  CCLoggerLevel.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 An enumeration type used to set the level type of a certain logged message.
 */
enum LoggerLevel: Int, Comparable, Codable {
    case verbose
    case debug
    case info
    case warning
    case error
    
    static func < (lhs: LoggerLevel, rhs: LoggerLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
