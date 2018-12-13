//
//  XCGLoggerCCLogger.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation
import XCGLogger

class XCGLoggerAdapter {
    
    let logger = XCGLogger(identifier: "logger", includeDefaultDestinations: false)
    
    /**
     Converts the received level to a XCGLogger.Level level.
     
     - parameters:
        - level: The CCLoggerLevel enum that should be converted.
     
     - returns:
     A XCGLogger.Level object that has the equivalent level to the received one.
     */
    private func xcgLoggerLevel(level: LoggerLevel) -> XCGLogger.Level {
        switch level {
        case .verbose:
            return .verbose
        case .debug:
            return .debug
        case .info:
            return .info
        case .warning:
            return .warning
        case .error:
            return .error
        }
    }
}

extension XCGLoggerAdapter : ILoggerLibraryAdapter {
    
    func setup(minimumLevel: LoggerLevel) { }
    
    func addDestination(destination: LoggerBaseDestination) {
        if let destination = destination as? LoggerFileDestination {
            // create & configure the file destination
            let fileUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(destination.fileName).path
            let fileDestination = FileDestination(writeToFile: fileUrl, identifier: "fileDestination")
            fileDestination.outputLevel = .verbose
            fileDestination.showLevel = false
            fileDestination.showFileName = false
            fileDestination.showFunctionName = false
            fileDestination.showLineNumber = false
            
            // add it to the logger
            logger.add(destination: fileDestination)
        }
        
        else if let _ = destination as? LoggerConsoleDestination {
            // create & configure the console destination
            let consoleDestination = ConsoleDestination(identifier: "consoleDestination")
            consoleDestination.outputLevel = .verbose
            consoleDestination.showLineNumber = false
            consoleDestination.showFileName = false
            consoleDestination.showLevel = false
            consoleDestination.showDate = false
            consoleDestination.showFunctionName = false
            
            // add it to the logger
            logger.add(destination: consoleDestination)
        }
    }
    
    func log(message: String, level: LoggerLevel, context: LoggerContext?) {
        
        // TODO: Construct the logged message based on information contained in the context parameter
        
        // log using the underlying XCGLogger object, based on the selected level
        switch level {
        case .verbose:
            logger.verbose(message)
        case .debug:
            logger.debug(message)
        case .info:
            logger.info(message)
        case .warning:
            logger.warning(message)
        case .error:
            logger.error(message)
        }
    }
}
