//
//  LocalTickerFinancials+CoreDataProperties.swift
//  
//
//  Created by Anton Gubarenko on 20.09.2021.
//
//

import Foundation
import CoreData


extension LocalTickerFinancials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTickerFinancials> {
        return NSFetchRequest<LocalTickerFinancials>(entityName: "LocalTickerFinancials")
    }

    @NSManaged public var pe_ratio: Double
    @NSManaged public var market_capitalization: Double
    @NSManaged public var highlight: String?
    @NSManaged public var dividend_growth: Float
    @NSManaged public var symbol: String?
    @NSManaged public var created_at: String?
    @NSManaged public var net_profit_margin: Double
    @NSManaged public var sma_30days: Double
    @NSManaged public var market_cap_cagr_1years: Double
    @NSManaged public var enterprise_value_to_sales: Double

}
