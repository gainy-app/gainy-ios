//
//  HoldingsModelMapper.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit

struct HoldingsModelMapper {
    static func modelsFor(holdings: [GetPlaidHoldingsQuery.Data.GetPortfolioHolding], transactions: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction], profileHoldings: GetProfileGainsQuery.Data.AppProfile?) -> [HoldingViewModel] {
        
        let profileID = UserProfileManager.shared.profileID ?? 0
        
        var holds: [HoldingViewModel] = []
        
        
        for rawHolding in holdings {
            let security: GetPlaidTransactionsQuery.Data.GetPortfolioTransaction.Security? = transactions.first(where: {
                $0.security.id == rawHolding.securityId
            }).map({$0.security})
            print("Sec: \(security?.id ?? 0)")
            print("Sec Name: \(security?.name ?? "")")
            let ticker = security?.tickers?.fragments.remoteTickerDetails
            let symbol = security?.tickerSymbol ?? ""
            
            let portfolioHoldingsGains = profileHoldings?.profileHoldings.first(where: {
                $0.securityId == security?.id
            })?.portfolioHoldingGains
            
            let portfolioTransactionsGains = profileHoldings?.profileHoldings.first(where: {
                $0.securityId == security?.id
            })?.holdingTransactions.filter({$0.securityId == security?.id}) ?? []
            
            
            let portfolioTransactions = transactions.filter({$0.securityId == security?.id})
            print("Sec tra: \(portfolioTransactions.count)")
            print("Sec tra gains: \(portfolioTransactionsGains.count)")
            
            var securities: [HoldingSecurityViewModel] = []
            for transaction in portfolioTransactions {
                let portfolioTransGains = portfolioTransactionsGains.first(where: {$0.portfolioTransactionGains?.transactionId == transaction.id})?.portfolioTransactionGains
                
                let absGains: [ScatterChartView.ChartPeriod : Float] = [
                    .d1 : Float(transaction.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                    .w1 : portfolioTransGains?.absoluteGain_1w ?? 0.0,
                    .m1 : portfolioTransGains?.absoluteGain_1m ?? 0.0,
                    .m3 : portfolioTransGains?.absoluteGain_3m ?? 0.0,
                    .y1 : portfolioTransGains?.absoluteGain_1y ?? 0.0,
                    .y5 : portfolioTransGains?.absoluteGain_5y ?? 0.0,
                    .all : portfolioTransGains?.absoluteGainTotal ?? 0.0
                  ]
                
                let relGains: [ScatterChartView.ChartPeriod : Float]  = [
                    .d1 : (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                    .w1 : portfolioTransGains?.relativeGain_1w ?? 0.0,
                    .m1 : portfolioTransGains?.relativeGain_1m ?? 0.0,
                    .m3 : portfolioTransGains?.relativeGain_3m ?? 0.0,
                    .y1 : portfolioTransGains?.relativeGain_1y ?? 0.0,
                    .y5 : portfolioTransGains?.relativeGain_5y ?? 0.0,
                    .all : portfolioTransGains?.relativeGainTotal ?? 0.0
                  ]
                
                let model = HoldingSecurityViewModel(name: transaction.name,
                                                     precentInHolding: Float(transaction.quantity / rawHolding.quantity),
                                                     totalPrice: Float(transaction.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0),
                                                     quantity: Float(transaction.quantity),
                                                     singlePrice: Float(transaction.price),
                                                     absoluteGains: absGains,
                                                     relativeGains: relGains)
                securities.append(model)
            }
            
            let absGains: [ScatterChartView.ChartPeriod : Float] = [
                .d1 : Float(rawHolding.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                .w1 : portfolioHoldingsGains?.absoluteGain_1w ?? 0.0,
                .m1 : portfolioHoldingsGains?.absoluteGain_1m ?? 0.0,
                .m3 : portfolioHoldingsGains?.absoluteGain_3m ?? 0.0,
                .y1 : portfolioHoldingsGains?.absoluteGain_1y ?? 0.0,
                .y5 : portfolioHoldingsGains?.absoluteGain_5y ?? 0.0,
                .all : portfolioHoldingsGains?.absoluteGainTotal ?? 0.0
              ]
            
            let relGains: [ScatterChartView.ChartPeriod : Float]  = [
                .d1 : (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                .w1 : portfolioHoldingsGains?.relativeGain_1w ?? 0.0,
                .m1 : portfolioHoldingsGains?.relativeGain_1m ?? 0.0,
                .m3 : portfolioHoldingsGains?.relativeGain_3m ?? 0.0,
                .y1 : portfolioHoldingsGains?.relativeGain_1y ?? 0.0,
                .y5 : portfolioHoldingsGains?.relativeGain_5y ?? 0.0,
                .all : portfolioHoldingsGains?.relativeGainTotal ?? 0.0
              ]
            
            let holdModel = HoldingViewModel.init(matchScore: TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0,
                                                  name: security?.name ?? "",
                                                  balance: Float(rawHolding.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0),
                                                  tickerSymbol: symbol,
                                                  industries: ticker?.tickerIndustries ?? [],
                                                  categories: ticker?.tickerCategories ?? [],
                                                  showLTT: rawHolding.holdingDetails.lttQuantityTotal ?? 0.0 > 0.0,
                                                  todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                                  todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                                  absoluteGains: absGains,
                                                  relativeGains: relGains,
                                                  percentInProfile:portfolioHoldingsGains?.valueToPortfolioValue ?? 0.0,
                                                  securities: securities,
                                                  holdingDetails: rawHolding.holdingDetails,
                                                  event: ticker?.tickerEvents.first?.description,
                                                  accountId: rawHolding.account.id,
                                                  tickerInterests: ticker?.tickerInterests.compactMap({$0.interestId}) ?? [],
                                                  tickerCategories: ticker?.tickerIndustries.compactMap({$0.gainyIndustry?.id}) ?? [])
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
    
    static func topChartGains(chartsCache: [ScatterChartView.ChartPeriod : [GetPortfolioChartsQuery.Data.PortfolioChart]], portfolioGains: GetProfileGainsQuery.Data.AppProfile?) -> [ScatterChartView.ChartPeriod : PortfolioChartGainsViewModel] {
        var models: [ScatterChartView.ChartPeriod : PortfolioChartGainsViewModel] = [:]
        
        for range in ScatterChartView.ChartPeriod.allCases {
            
            switch range {
            case .d1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: 1.23,
                                                                       rangeGrowBalance: 2233,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
                break
            case .w1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGain_1w ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGain_1w ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            case .m1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGain_1m ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGain_1m ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            case .m3:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGain_3m ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGain_3m ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            case .y1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGain_1y ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGain_1y ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            case .y5:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGain_5y ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGain_5y ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            case .all:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: portfolioGains?.portfolioGains?.relativeGainTotal ?? 0.0,
                                                                       rangeGrowBalance: portfolioGains?.portfolioGains?.absoluteGainTotal ?? 0.0,
                                                                       chartData: ChartData.init(points: chartsCache[range] ?? [],
                                                                                                 period: range))
                models[range] = chartGainModel
            }
            
            
        }
        
        return models
    }
}
