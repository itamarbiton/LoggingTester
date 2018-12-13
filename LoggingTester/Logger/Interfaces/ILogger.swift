//
//  ILoggr.swift
//  LoggingTester
//
//  Created by Itamar Biton on 12/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 Describes a logger object used for logging system messags
 */
protocol ILogger {
    /**
     Logs a message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
     */
    func log(message: String, level: LoggerLevel, context: LoggerContext?)
}

extension ILogger {
    /**
     Logs a 'verbose' level message.
     
     - parameters:
     - message: The message that should be logged.
     - context: The context in which the message was logged.
     */
    func verbose(message: String, context: LoggerContext? = nil) { log(message: message, level: .verbose, context: context) }
    
    /**
     Logs a 'debug' level message.
     
     - parameters:
     - message: The message that should be logged.
     - context: The context in which the message was logged.
     */
    func debug(message: String, context: LoggerContext? = nil) { log(message: message, level: .debug, context: context) }
    
    /**
     Logs a 'info' level message.
     
     - parameters:
     - message: The message that should be logged.
     - context: The context in which the message was logged.
     */
    func info(message: String, context: LoggerContext? = nil) { log(message: message, level: .info, context: context) }
    
    /**
     Logs a 'warning' level message.
     
     - parameters:
     - message: The message that should be logged.
     - context: The context in which the message was logged.
     */
    func warning(message: String, context: LoggerContext? = nil) { log(message: message, level: .warning, context: context) }
    
    /**
     Logs a 'error' level message.
     
     - parameters:
     - message: The message that should be logged.
     - context: The context in which the message was logged.
     */
    func error(message: String, context: LoggerContext? = nil) { log(message: message, level: .error, context: context) }
    
}

