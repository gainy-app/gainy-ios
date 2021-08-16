//
//  OSLog+Additions.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.08.2021.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
    
    /// Log debug info
    static let debugInfo = OSLog(subsystem: subsystem, category: "debugInfo")
}
