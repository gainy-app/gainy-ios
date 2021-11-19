//
//  TickerDetailsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit


final class TickerDetailsViewModel: NSObject, CardDetailsViewModelProtocol {
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        self.dataSource = TickerDetailsDataSource(ticker: ticker)
    }
    
    let ticker: TickerInfo
    let dataSource: TickerDetailsDataSource
    
    //MARK: - Compare Logic
    
    var tickersToCompare: [AltStockTicker] = []
    
    func compareToggled(_ stock: AltStockTicker) {
        
        //Always adding current stock to compare

        if !(tickersToCompare.contains(ticker.ticker)) {
            tickersToCompare.insert(ticker.ticker, at: 0)
        }
        
        if let stockIndex = tickersToCompare.firstIndex(where: {$0.symbol == stock.symbol}) {
            tickersToCompare.remove(at: stockIndex)
        } else {
            tickersToCompare.append(stock)
        }

    }
    
    func compareCollectionDTO() -> CollectionDetailViewCellModel {
        return CollectionDetailViewCellModel(
            id: Constants.CollectionDetails.compareCollectionID,
            image: "compare_stocks",
            imageUrl: "",
            name: "Compared Stocks",
            description: "",
            stocksAmount: "\(tickersToCompare.count)",
            inYourCollectionList: false,
            cards: tickersToCompare.map { CollectionDetailsViewModelMapper.map(CollectionDetailsDTOMapper.mapTickerDetails(
                $0
            ))}
        )
    }
}


