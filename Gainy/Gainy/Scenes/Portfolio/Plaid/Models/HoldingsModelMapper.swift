//
//  HoldingsModelMapper.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit

struct HoldingsModelMapper {
    static func modelsFor(holdings: [GetPlaidHoldingsQuery.Data.GetPortfolioHolding], securities: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction]) -> [HoldingViewModel] {
        return []
    }
}
