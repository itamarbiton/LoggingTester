//
//  DefaultConfigurationProvider.swift
//  LoggingTester
//
//  Created by Itamar Biton on 12/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 A default, hard-coded concrete implementation of the `ILoggerDestinationsProvider` protocol
 
 The default configuration for the logger is as follows:
 
    - Minimum level set to `verbose`
    - Underlying adapter set the XCGLogger
    - 1 console destination
    - 1 file destination to a file in the caches folder named `climacell_log.log`
 
 Conform the `ILoggerDestinationsProvider` to implement another type of a destinations provider (e.g. for a remote server)
 */
class DefaultLoggerDestinationsProvider : ILoggerDestinationsProvider {
    func getDestinations() -> [LoggerBaseDestination]? {
        // set the minimum level to verbose
        let minimumLevel: LoggerLevel = .verbose
        
        // create an adapter
        let adapter = XCGLoggerAdapter()
        
        // create the destinations
        let console = LoggerConsoleDestination(adapter: adapter, minimumLevel: minimumLevel)
        let file = LoggerFileDestination(adapter: adapter, minimumLevel: .verbose, fileName: "climacell_log.log")
        let destinations = [console, file]
        
        return destinations
    }
}
