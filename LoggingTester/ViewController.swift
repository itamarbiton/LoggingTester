//
//  ViewController.swift
//  LoggingTester
//
//  Created by Itamar Biton on 11/12/2018.
//  Copyright © 2018 Itamar Biton. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get a logger
        let logger = LoggerFactory.get
        logger.verbose(message: "should only be logged to 1", context: LoggerContext.SampleContext(parameter1: 1, parameter2: "test", parameter3: true))
    }
}







