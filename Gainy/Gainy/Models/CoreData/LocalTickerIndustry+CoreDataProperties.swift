//
//  LocalTickerIndustry+CoreDataProperties.swift
//  
//
//  Created by Anton Gubarenko on 20.09.2021.
//
//

import Foundation
import CoreData


extension LocalTickerIndustry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTickerIndustry> {
        return NSFetchRequest<LocalTickerIndustry>(entityName: "LocalTickerIndustry")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int32

}
