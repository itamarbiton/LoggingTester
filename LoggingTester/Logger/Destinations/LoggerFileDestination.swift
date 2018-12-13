//
//  CCLoggerFileDestination.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 A destination that represents a local file
 */
class LoggerFileDestination : LoggerBaseDestination {
    
    /** The name of the file */
    let fileName: String
    
    /**
     Initializes a new file destination
     
     - parameters:
        - adapter: The adapter used perform the logging
        - minimumLevel: The minimum level a message should be to get logged to this destination
        - contexts: A dictionary containig pairs of contexts that should be logged to this destination accompanied by `true` as value
        - fileName: The name of the file the logs should be written to
     */
    init(adapter: ILoggerLibraryAdapter, minimumLevel: LoggerLevel, contexts: [String: Bool]? = nil, fileName: String) {
        self.fileName = fileName
        super.init(adapter: adapter, minimumLevel: minimumLevel, contexts: contexts)
    }
}
