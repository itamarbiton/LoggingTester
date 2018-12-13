//
//  JSONLoggerDestinationsProvider.swift
//  LoggingTester
//
//  Created by Itamar Biton on 13/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

class JSONLoggerDestinationsProvider : ILoggerDestinationsProvider {
    
    /** The name of the local JSON file */
    let fileName: String
    
    /**
     Initializes a new `JSONLoggerDestinationsProvider` that loads configuration from the specified file
     
     - parameters:
        - fileName: The name of the local JSON file that contains the configuration, defaults to "LoggerConfiguration"
     */
    init(fileName: String = "LoggerConfiguration") {
        self.fileName = fileName
    }
    
    func getDestinations() -> [LoggerBaseDestination]? {
        // create a decoder
        let decoder = JSONDecoder()
        
        // get the configuration
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: url),
            let destArr = try? decoder.decode(JSONDestinationsConfiguration.self, from: jsonData)
        else {
                return nil
        }
        
        var destinations: [LoggerBaseDestination] = []
        for dest in destArr.destinations {
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
            switch dest.type {
            case ConfigurationValues.DestinationType.console:
                destinations.append(LoggerConsoleDestination(adapter: adapter, minimumLevel: dest.minimumLevel, contexts: dest.contexts))
            case ConfigurationValues.DestinationType.file:
                destinations.append(LoggerFileDestination(adapter: adapter, minimumLevel: dest.minimumLevel, contexts: dest.contexts, fileName: dest.fileName!))
                
            default:
                return nil
            }
        }
        
        return nil
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
    
    struct JSONDestinationsConfiguration : Codable {
        var destinations: [JSONDestinationConfiguration]
    }
    
    struct JSONDestinationConfiguration : Codable {
        var engine: String
        var type: String
        var minimumLevel: LoggerLevel
        var contexts: [String : Bool]?
        var fileName: String?
    }
}
