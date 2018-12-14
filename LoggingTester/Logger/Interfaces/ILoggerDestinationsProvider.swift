//
//  ILoggerConfigurationProvider.swift
//  LoggingTester
//
//  Created by Itamar Biton on 12/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 Describes a destinations provider - a utility object used to get a list of destinations to initialize
 a logger object.
 */
protocol ILoggerDestinationsProvider {
    func getDestinations() -> [LoggerBaseDestination]?
}

extension ILoggerDestinationsProvider {
    
    /**
     Parses an array of configuration objects into an array of destination objects
     
     - parameters:
        - destinationsConfiguration: The configuration object of the destinations' configuration
     
     - returns:
     An array of configured `LoggerBaseDestination` objects
     */
    func parseDestinations(destinationsConfiguration: LocalDestinationsConfiguration) -> [LoggerBaseDestination]? {
        var destinations: [LoggerBaseDestination] = []
        for dest in destinationsConfiguration.destinations {
            // get the adapter
            let adapter: ILoggerLibraryAdapter
            switch dest.engine {
            case ConfigurationValues.Library.XCGLogger:
                adapter = XCGLoggerAdapter()
            case ConfigurationValues.Library.SwiftyBeaver:
                adapter = SwiftyBeaverAdapter()
            default:
                return nil
            }
            
            // create a destination based on type
            let newDest: LoggerBaseDestination
            switch dest.type {
            case ConfigurationValues.DestinationType.console:
                newDest = LoggerConsoleDestination(adapter: adapter, minimumLevel: dest.minimumLevel, contexts: dest.contexts)
            case ConfigurationValues.DestinationType.file:
                newDest = LoggerFileDestination(adapter: adapter, minimumLevel: dest.minimumLevel, contexts: dest.contexts, fileName: dest.fileName!)
            default:
                return nil
            }
            
            // configure the formatting
            newDest.showDate = dest.showDate ?? true
            newDest.showFileName = dest.showFileName ?? true
            newDest.showFunctionName = dest.showFunctionName ?? true
            newDest.showLineNumber = dest.showLineNumber ?? true
            newDest.showLevel = dest.showLevel ?? true
            
            destinations.append(newDest)
        }
        
        return destinations
    }
}

struct ConfigurationValues {
    struct DestinationType {
        static let console = "console"
        static let file = "file"
    }
    struct Library {
        static let XCGLogger = "XCGLogger"
        static let SwiftyBeaver = "SwiftyBeaver"
    }
}

struct LocalDestinationsConfiguration : Codable {
    var destinations: [LocalDestinationConfiguration]
}

struct LocalDestinationConfiguration : Codable {
    var engine: String
    var type: String
    var minimumLevel: LoggerLevel
    var contexts: [String : Bool]?
    var showLevel: Bool?
    var showDate: Bool?
    var showFileName: Bool?
    var showFunctionName: Bool?
    var showLineNumber: Bool?
    var fileName: String?
}
