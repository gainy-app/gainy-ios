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
    static let didLoadProfile = Notification.Name("didLoadProfile")
    static let didPickProfileImage = Notification.Name("didPickProfileImage")
    static let didChangeProfileCategories = Notification.Name("didChangeProfileCategories")
    static let didChangeProfileInterests = Notification.Name("didChangeProfileInterests")
    static let didFailToRefreshToken = Notification.Name("didFailToRefreshToken")
    static let didUpdateScoringSettings = Notification.Name("didUpdateScoringSettings")
    static let didUpdateWatchlist = Notification.Name("didUpdateWatchlist")
}
