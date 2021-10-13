//
//  DDLog.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.10.2021.
//

@_exported import BugfenderSDK

func dprint(_ msg: CustomStringConvertible, _ error: Error? = nil) {
    bfprint(msg.description)
}

//final class DDLog {
//
//    static let logger =  Logger.builder
//        .sendNetworkInfo(true)
//        .printLogsToConsole(true, usingFormat: .shortWith(prefix: "[iOS App] "))
//        .build()
//}
