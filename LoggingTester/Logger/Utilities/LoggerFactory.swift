//
//  CCLoggerAdapter.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import Foundation

class LoggerFactory {
    static var get: ILogger =
        Logger(destinations: (JSONLoggerDestinationsProvider().getDestinations())
            ?? DefaultLoggerDestinationsProvider().getDestinations()!)
}
