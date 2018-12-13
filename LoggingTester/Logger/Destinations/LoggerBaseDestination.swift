//
//  CCLoggerBaseDestination.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 A class the defines the base for a logging destination
 */
class LoggerBaseDestination {
    
    /** The engine used by the destination */
    let libraryAdapter: ILoggerLibraryAdapter
    
    /** A dictionary that contains the contexts that should be logged to the destination,
     leaving this values as `nil` will log all contexts */
    let contexts: [String: Bool]?
    
    /** The minimum level messages should be to get logged to the destination */
    let minimumLevel: LoggerLevel
    
    /** A date formatter used to display the time & date the message was logged */
    let dateFormatter: DateFormatter
    
    var showFunctionName = true
    var showFileName = true
    var showLevel = true
    var showLineNumber = true
    var showDate = true
    
    /**
     Initializes a new base logger destination
     
     - parameters:
        - minimumLevel: The minimum level a message should be to get logged to the destination
        - contexts: A dictionary that contains the list of contexts that should be logged to the
            destination as keys, accompanied with `true` as value
     */
    init(adapter: ILoggerLibraryAdapter, minimumLevel: LoggerLevel, contexts: [String: Bool]? = nil) {
        self.minimumLevel = minimumLevel
        self.contexts = contexts
        self.libraryAdapter = adapter
        
        // configure the date formatter
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        // add the destination to the engine
        libraryAdapter.addDestination(destination: self)
    }
    
    /**
     Logs a certain message to the destination
     */
    func log(message: String, level: LoggerLevel, context: LoggerContext?, fileName: String, functionName: String, lineNumber: Int) {
        let processedMessage = process(message: message, level: level, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
        libraryAdapter.log(message: processedMessage, level: level, context: context)
    }
    
    /**
     Checks whether a certain combination of level and context are qualified to get logged to this
     destination
     
     - parameters:
        - level: The target level
        - context: The target context
     
     - returns:
     `true` if the combination is qualified, `false` if not
     */
    func shouldLog(withLevel level: LoggerLevel, context: LoggerContext?) -> Bool {
        return (shouldLog(level: level) || shouldLog(withContext: context))
    }
    
    
    /**
     Checks whether a ceratin level is high enough to get logged to this destiantion
     
     - parameters:
        - level: The target level
     
     - returns:
     `true` if the level is high enough, `false` if not
     */
    private func shouldLog(level: LoggerLevel) -> Bool {
        return (level >= self.minimumLevel)
    }
    
    /**
     Processes the mesasge and formats it according to the configuration of the location
     
     - parameters:
         - message: The log's message
         - level: The log's message level of importance
         - fileName: The name of the file the log came from
         - functionName: The name of the function the log came from
         - lineNumber: The number of the line the log was invoked from
     */
    private func process(message: String, level: LoggerLevel, fileName: String, functionName: String, lineNumber: Int) -> String {
        var processedMessage: String = ""
        
        if (showDate) {
            processedMessage += "[\(dateFormatter.string(from: Date()))]"
        }
        
        if (showFileName) {
            let pathHead = (fileName as NSString).lastPathComponent
            if (showLineNumber) { processedMessage += "[\(pathHead):\(lineNumber)]" } else { processedMessage += "[\(fileName)]" }
        }
        
        if (showLevel) {
            processedMessage += "[\(level)]"
        }
        
        return (processedMessage + "> \(message)")
    }
    
    /**
     Checks whether a certain context should be logged to this destination
     
     - parameters:
        - context: The target context
     
     - returns:
     `true` if the context should be logged, `false` if not
     */
    private func shouldLog(withContext context: LoggerContext?) -> Bool {
        // make sure there's a context, and if not just return true
        guard let context = context else {
            return true
        }
        
        // if the context is listed, return true
        return self.contexts?[context.name] ?? false
    }
}
