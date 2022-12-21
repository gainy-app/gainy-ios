//
//  UserDefaultsPurchaseInfoStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import UIKit
import OneSignal
import Combine
import SwiftDate
import GainyCommon

class UserDefaultsPurchaseInfoStorage: PurchaseInfoStorageProtocol {
    
    var collectionViewLimit: Int {
        3
    }
    
    static let colKey: String = "Purchases.viewedCollections"
    static let firstAddKey: String = "Purchases.firstAdd"
    
    @UserDefaultArray(key: colKey)
    private var viewedCollections: [Int]
    
    @UserDefault(firstAddKey)
    private var firstAddDate: Date?
    
    var viewedCount: Int {
        min(viewedCollections.count, collectionViewLimit)
    }
    
    func getViewedCollections() {
//        OneSignal.getTags({[weak self] tags in
//            var viewedCols: [Int] = []
//            var viewedDate: Date?
//            for tag in (tags ?? [:]) {
//                if tag.key as? String == UserDefaultsPurchaseInfoStorage.colKey {
//                    viewedCols = (tag.value as? String)?.split(separator: ",").compactMap({Int($0)}) ?? []
//                }
//                if tag.key as? String == UserDefaultsPurchaseInfoStorage.firstAddKey, let date = UserDefaultsPurchaseInfoStorage.iso8601DateFormatter.date(from: (tag.value as? String) ?? "") {
//                    viewedDate = date
//                }
//            }
//
//            //Handling
//            if let viewedDate = viewedDate {
//                //Getting month after first view
//                let monthAfter = viewedDate + 1.months
//
//                if Date() < monthAfter {
//                    self?.viewedCollections = viewedCols
//                } else {
//                    //Reset
//                    viewedCols = []
//                    self?.viewedCollections = viewedCols
//                    //Updating OS
//                    OneSignal.sendTag(UserDefaultsPurchaseInfoStorage.colKey, value: viewedCols.compactMap({String($0)}).joined(separator: ","))
//                    OneSignal.sendTag(UserDefaultsPurchaseInfoStorage.firstAddKey, value: UserDefaultsPurchaseInfoStorage.iso8601DateFormatter.string(from: Date()))
//                }
//            } else {
//                self?.viewedCollections = viewedCols
//            }
//
//            self?.collectionsViewedSubject.value = self?.viewedCount ?? 0
//            self?.firstAddDate = viewedDate
//        }, onFailure: { error in
//            dprint("Error getting tags - \(error?.localizedDescription)")
//        })
    }
    
    private let collectionsViewedSubject: CurrentValueSubject<Int, Never> = CurrentValueSubject.init(0)
    
    var collectionsViewedPublisher: AnyPublisher<Int, Never> {
        collectionsViewedSubject.share().eraseToAnyPublisher()
    }
    
    func isViewedCollection(_ colId: Int) -> Bool {
        //viewedCollections.contains(colId)
        return true
    }
    
    func viewCollection(_ colId: Int) -> Bool {
//        guard viewedCollections.count < collectionViewLimit else {return false}
//        if !viewedCollections.contains(colId) {
//            viewedCollections.append(colId)
//            collectionsViewedSubject.value = viewedCount
//            OneSignal.sendTag(UserDefaultsPurchaseInfoStorage.colKey, value: viewedCollections.compactMap({String($0)}).joined(separator: ","))
//            if firstAddDate == nil {
//                firstAddDate = Date()
//                OneSignal.sendTag(UserDefaultsPurchaseInfoStorage.firstAddKey, value: UserDefaultsPurchaseInfoStorage.iso8601DateFormatter.string(from: Date()))
//            }
//        }
        return true
    }
    
}
