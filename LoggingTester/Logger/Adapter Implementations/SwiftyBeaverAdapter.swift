//
//  SwiftyBeaverAdapter.swift
//  LoggingTester
//
//  Created by Itamar Biton on 13/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import UIKit
import SwiftyBeaver

class SwiftyBeaverAdapter: ILoggerLibraryAdapter {
    
    var destination:  BaseDestination?
    
    private func swiftyBeaverLoggerLevel(level: LoggerLevel) -> SwiftyBeaver.Level {
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
    
    func setup(minimumLevel: LoggerLevel) {
        
    }
    
    func log(message: String, level: LoggerLevel, context: LoggerContext?) {
        _ = destination?.send(swiftyBeaverLoggerLevel(level: level),
                              msg: message,
                              thread: "",
                              file: "",
                              function: "",
                              line: 0)
    }
    
    func addDestination(destination: LoggerBaseDestination) {
        // create a swifty beaver destination based on the received one
        if let loggerFileDest = destination as? LoggerFileDestination {
            // create the url of the log file
            let fileUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(loggerFileDest.fileName)
            
            // create the file destination
            let fileDest = FileDestination()
            fileDest.logFileURL = fileUrl
            fileDest.format = "$M"
            self.destination = fileDest
        }
        
        else if let _ = destination as? LoggerConsoleDestination {
            let consoleDest = ConsoleDestination()
            consoleDest.format = "$M"
            self.destination = consoleDest
        }
        
        else {
            // do nothing...
        }
    }
}
