//
//  LocalCollection+CoreDataProperties.swift
//  
//
//  Created by Anton Gubarenko on 20.09.2021.
//
//

import Foundation
import CoreData


extension LocalCollection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalCollection> {
        return NSFetchRequest<LocalCollection>(entityName: "LocalCollection")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image_url: String?
    @NSManaged public var desc: String?
    @NSManaged public var stocks_count: Int32
    @NSManaged public var tickers: LocalTicker?

}
