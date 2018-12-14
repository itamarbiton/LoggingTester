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
            let destArr = try? decoder.decode(LocalDestinationsConfiguration.self, from: jsonData)
        else {
                return nil
        }
        
        return parseDestinations(destinationsConfiguration: destArr)
    }
}
