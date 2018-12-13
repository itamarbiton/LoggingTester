//
//  CCLoggerContext.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 Additional information that accompanies a certain logged message.
 */
struct LoggerContext {
    
    /** The name of the context */
    var name: String
    
    /** A dictionary of context-related parameters the accompany the log message */
    var parameters: [String: LosslessStringConvertible]
}

extension LoggerContext {
    
    struct SampleContextFields {
        static let name = "sample"
        static let parameter1 = "parameter1"
        static let parameter2 = "parameter2"
        static let parameter3 = "parameter3"
    }
    
    static func SampleContext(parameter1: Int, parameter2: String, parameter3: Bool) -> LoggerContext {
        var parameters: [String: LosslessStringConvertible] = [:]
        parameters[SampleContextFields.parameter1] = parameter1
        parameters[SampleContextFields.parameter2] = parameter2
        parameters[SampleContextFields.parameter3] = parameter3
        return LoggerContext(name: SampleContextFields.name, parameters: parameters)
    }
    
}
