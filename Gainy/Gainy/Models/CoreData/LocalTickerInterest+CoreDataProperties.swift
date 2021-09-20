//
//  LocalTickerInterest+CoreDataProperties.swift
//  
//
//  Created by Anton Gubarenko on 20.09.2021.
//
//

import Foundation
import CoreData


extension LocalTickerInterest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTickerInterest> {
        return NSFetchRequest<LocalTickerInterest>(entityName: "LocalTickerInterest")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var interest_id: Int32
    @NSManaged public var icon_url: String?
    @NSManaged public var name: String?

}
