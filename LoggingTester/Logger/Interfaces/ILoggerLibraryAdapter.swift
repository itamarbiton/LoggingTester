//
//  ICCLogger.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 Describes the actual logging object used to log messages - conform to this protocol to implement
 logic related to logging and sending messages.
 */
protocol ILoggerLibraryAdapter {
    
    /**
     Initializes and configures the logger.
     */
    func setup(minimumLevel: LoggerLevel)
    
    /**
     Logs a message.
     
     - Parameter message: The actual message that should be logged.
     - Parameter context: The context in which the message is being logged in.
     */
    func log(message: String, level: LoggerLevel, context: LoggerContext?)
    
    /**
     Adds a logging destination to the logger.
     
     - parameter:
        - destination: The destination to be added.
     */
    func addDestination(destination: LoggerBaseDestination)
}
