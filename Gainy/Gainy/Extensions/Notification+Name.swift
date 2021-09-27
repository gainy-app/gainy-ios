//
//  Notification+Name.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import Foundation

extension Notification.Name {
    
    static let didReceiveFirebaseAuthToken = Notification.Name("didReceiveFirebaseAuthToken")
    static let didRequestFirebaseAuthToken = Notification.Name("didRequestFirebaseAuthToken")
}
