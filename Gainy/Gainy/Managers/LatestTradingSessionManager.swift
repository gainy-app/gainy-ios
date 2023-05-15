//
//  LatestTradingSessionManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.03.2023.
//

import UIKit
import GainyAPI
import SwiftDate
import GainyCommon

final class LatestTradingSessionManager {
    static let shared = LatestTradingSessionManager()
    
    //MARK: - Dates
    
    private var portOpenDate: Date?
    var firstPortoDate: Date? = nil
    
    
    var is15PortoMarketOpen: Bool {
        if let firstPortoDate = firstPortoDate {
            if let portOpenDate {
                if firstPortoDate >= portOpenDate {
                    return false
                }
            }
        }
        if let portOpenDate {
            return portOpenDate <= Date() && Date() <= portOpenDate.addingTimeInterval(60.0 * 20.0)
        } else {
            return false
        }
    }
    
    //MARK: - Fetching
    
    /// Get latest Porto open date
    /// - Parameter profileID: User Profile ID
    /// - Returns: session data
    @discardableResult func getProfileSession(profileID: Int?) async -> Date? {
        guard let profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetPortfolioLatestTradingSessionQuery(profileId: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let openDates = graphQLResult.data?.portfolioLatestTradingSession.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    self.portOpenDate = openDates.openAt?.toDate(DateFormat.yyyyMMddHHmmss.rawValue)?.date
                    continuation.resume(returning: self.portOpenDate)
                case .failure( _):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    
    /// Get latest TTF open date
    /// - Parameter uniqID: Collection ID
    /// - Returns: session data
    func getTTFSession(uniqID: String) async -> Date? {
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetCollectionLatestTradingSessionQuery(collection_uniq_id: uniqID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let openDates = graphQLResult.data?.collectionLatestTradingSession.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: openDates.openAt?.toDate(DateFormat.yyyyMMddHHmmss.rawValue)?.date)
                case .failure( _):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
