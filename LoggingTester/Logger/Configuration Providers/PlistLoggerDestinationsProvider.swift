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
        
        // get the configuration
        guard
            let path = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let plistData = try? Data(contentsOf: path),
            let destArr = try? decoder.decode(JSONDestinationsConfiguration.self, from: plistData)
        else {
            return nil
        }
        
        return parseDestinations(destinationsConfiguration: destArr)
    }
    
}
