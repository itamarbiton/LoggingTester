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
