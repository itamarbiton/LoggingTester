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
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func log(message: String, level: LoggerLevel, context: LoggerContext?, fileName: String, functionName: String,  lineNumber: Int)
}

extension ILogger {
    
    /**
     Logs a 'verbose' level message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func verbose(message: String, context: LoggerContext? = nil, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) { log(message: message, level: .verbose, context: context, fileName: fileName, functionName: functionName, lineNumber: lineNumber) }
    
    /**
     Logs a 'debug' level message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func debug(message: String, context: LoggerContext? = nil, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) { log(message: message, level: .debug, context: context, fileName: fileName, functionName: functionName, lineNumber: lineNumber) }
    
    /**
     Logs a 'info' level message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func info(message: String, context: LoggerContext? = nil, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) { log(message: message, level: .info, context: context, fileName: fileName, functionName: functionName, lineNumber: lineNumber) }
    
    /**
     Logs a 'warning' level message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func warning(message: String, context: LoggerContext? = nil, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) { log(message: message, level: .warning, context: context, fileName: fileName, functionName: functionName, lineNumber: lineNumber) }
    
    /**
     Logs a 'error' level message.
     
     - parameter:
        - message: The actual message that should be logged
        - level: The logged message's level of importance
        - context: The context in which the message was logged, used to supply additional important information
        - fileName: The name of the file that the log came from
        - functionName: The name of the function that the log came from
        - lineNumber: The line number the log was invoked from
     */
    func error(message: String, context: LoggerContext? = nil, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) { log(message: message, level: .error, context: context, fileName: fileName, functionName: functionName, lineNumber: lineNumber) }
    
}

