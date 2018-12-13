//
//  LoggerConfigurationProvider.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

/**
 Responsible for fetching the configuration of the logger from the various available sources
 */
class PlistLoggerDestinationsProvider : ILoggerDestinationsProvider {
    
    enum PlistConfigurationProviderError : Error {
        case invalidConfigurationFile
    }
    
    struct ConfigurationKeys {
        static let destinations = "destinations"
        struct Destination {
            static let engine = "engine"
            static let type = "type"
            static let minimumLevel = "minimumLevel"
            static let fileName = "filename"
            static let contexts = "contexts"
            struct DestinationType {
                static let console = "console"
                static let file = "file"
            }
        }
    }
    
    /** The name of the .plist file used to create the logger's configuration */
    let fileName: String
    
    /**
     Initializes a new `PlistConfigurationProvider`.
     
     - parameters:
        - fileName: The name of the .plist file that holds the logger's configuration
     */
    init(fileName: String = "LoggerConfiguration") {
        self.fileName = fileName
    }
    
    func getDestinations() -> [LoggerBaseDestination]? {
        // create a decode
        let decoder = PropertyListDecoder()
        
        guard
            let path = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let plistData = try? Data(contentsOf: path),
            let destArr = try? decoder.decode(JSONDestinationsConfiguration.self, from: plistData)
        else {
            return nil
        }
        
        return parseDestinations(destinationsConfiguration: destArr)
    }
    
    /**
     Read the configuration from a .plist file named LoggerConfiguration.plist and returns an array of
     configured logging destinations
     
     - returns:
     An array of `LoggerBaseDestination` objects configured according to the configuration file
     */
    func oldGetDestinations() -> [LoggerBaseDestination]? {
        guard
            let path = Bundle.main.url(forResource: "LoggerConfiguration", withExtension: "plist"),
            let configDict = NSDictionary(contentsOf: path) as? [String : Any]
        else {
            return nil
        }
        
        return try? getDestinations(fromDictionary: configDict)
    }
    
    /**
     Parses a dictionary object that contains an array of destination configuration dictionaries
     
     - parameters:
        - dict: A dictionary that contains an array of destination configuration dictionaries
     
     - returns:
     An array that contains configured `LoggerBaseDestination` objects
     */
    private func getDestinations(fromDictionary dict: [String : Any]) throws -> [LoggerBaseDestination] {
        // get the array of destinations
        guard let destArr = dict[ConfigurationKeys.destinations] as? [[String : Any]] else {
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
        
        // iterate over the array and get the destinations
        var destinations: [LoggerBaseDestination] = []
        for destDict in destArr {
            destinations.append(try getDestination(fromDictionary: destDict))
        }
        
        return destinations
    }
    
    /**
     Parses a dictionary that contains destination configuration information
     
     - parameters:
        - dict: A dictionary that contains destination configuration information
     
     - returns:
     A configured `LoggerBaseDestination` object
     */
    private func getDestination(fromDictionary dict: [String : Any]) throws -> LoggerBaseDestination {
        // get the selected minimum logging level
        let selectedMinLevel: LoggerLevel
        guard
            let levelRawValue = dict[ConfigurationKeys.Destination.minimumLevel] as? Int,
            let level = LoggerLevel(rawValue: levelRawValue)
        else {
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
        selectedMinLevel = level
        
        // get the selected contexts that should be logged to the destination
        let contexts = getDestinationContexts(fromDictionary: dict)
        
        // get the destination type
        guard let destTypeString = dict[ConfigurationKeys.Destination.type] as? String else {
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
        
        // get the engine
        guard let engineString = dict[ConfigurationKeys.Destination.engine] as? String else {
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
        
        // set the engine
        let adapter: ILoggerLibraryAdapter
        switch engineString {
        case "XCGLogger":
            adapter = XCGLoggerAdapter()
        case "SwiftyBeaver":
            adapter = SwiftyBeaverAdapter()
        default:
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
        
        // act based on type
        switch destTypeString {
        case ConfigurationKeys.Destination.DestinationType.console:
            return LoggerConsoleDestination(adapter: adapter, minimumLevel: selectedMinLevel, contexts: contexts)
            
        case ConfigurationKeys.Destination.DestinationType.file:
            guard let fileName = dict[ConfigurationKeys.Destination.fileName] as? String else {
                throw PlistConfigurationProviderError.invalidConfigurationFile
            }
            return LoggerFileDestination(adapter: adapter,
                                         minimumLevel: selectedMinLevel,
                                         contexts: contexts, fileName: fileName)
        default:
            throw PlistConfigurationProviderError.invalidConfigurationFile
        }
    }
    
    /**
     Parses a dictionary that contains the list of contexts allowed to get log on a destination
     
     - parameters:
     - dict: A dictionary that contains information of the allowed contexts
     
     - returns;
     A dictionary that contains key-value pairs of allowed context names accompanied by `true` value
     */
    private func getDestinationContexts(fromDictionary dict: [String : Any]) -> [String: Bool]? {
        return dict[ConfigurationKeys.Destination.contexts] as? [String: Bool]
    }
}
