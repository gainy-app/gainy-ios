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
        
<<<<<<< HEAD
        if !(tickersToCompare.contains(ticker.ticker)) {
            tickersToCompare.insert(ticker.ticker, at: 0)
        }
        
        if let stockIndex = tickersToCompare.firstIndex(where: {$0.symbol == stock.symbol}) {
            tickersToCompare.remove(at: stockIndex)
        } else {
            tickersToCompare.append(stock)
        }
=======
//        if !(tickersToCompare.contains(ticker.ticker) ?? false) {
//            tickersToCompare.insert(curStock, at: 0)
//        }
//        
//        if let stockIndex = ticker.tickersToCompare.firstIndex(where: {$0.symbol == stock.symbol}) {
//            tickersToCompare.remove(at: stockIndex)
//        } else {
//            tickersToCompare.append(stock)
//        }
>>>>>>> 08644464df0fa223e75d10f817dbd36d8d13ba55
    }
    
    func compareCollectionDTO() -> CollectionDetailViewCellModel {
        let models: [CollectionCardViewCellModel] = []
        return CollectionDetailViewCellModel(
            id: -2,
            image: "compare_stocks",
            imageUrl: "",
            name: "Compared Stocks",
            description: "List of stock to compare",
            stocksAmount: "\(tickersToCompare.count)",
            inYourCollectionList: false,
<<<<<<< HEAD
            cards: tickersToCompare.map { CollectionDetailsViewModelMapper.map(CollectionDetailsDTOMapper.mapTickerDetails(
                $0
            ))}
=======
            cards: models //tickersToCompare.map { CollectionDetailsViewModelMapper.map($0)
>>>>>>> 08644464df0fa223e75d10f817dbd36d8d13ba55
        )
    }
}


