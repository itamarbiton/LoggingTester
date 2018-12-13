//
//  Logger.swift
//  LoggingTester
//
//  Created by Itamar Biton on 12/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

class Logger: ILogger {
    
    /** An array of destinations the log should be sent to */
    let destinations: [LoggerBaseDestination]
    
    /**
     Initializes a new logger
     
     - parameters:
     - engine: The engine used to perform the actual logging
     - destinations: An array of `LoggerBaseDestination` that represents the logger's logging destinations
     */
    init(destinations: [LoggerBaseDestination]) {
        self.destinations = destinations
    }
    
    func log(message: String, level: LoggerLevel, context: LoggerContext?) {
        for destination in destinations {
             if (destination.shouldLog(withLevel: level, context: context)) {
                destination.log(message: message, level: level, context: context)
            }
        }
    }
    
}
