//
//  LocalTicker+CoreDataProperties.swift
//  
//
//  Created by Anton Gubarenko on 20.09.2021.
//
//

import Foundation
import CoreData


extension LocalTicker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTicker> {
        return NSFetchRequest<LocalTicker>(entityName: "LocalTicker")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var collection: LocalCollection?
    @NSManaged public var financials: LocalTickerFinancials?
    @NSManaged public var interests: LocalTickerInterest?
    @NSManaged public var industries: LocalTickerIndustry?

}
