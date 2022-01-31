//
//  MarketDataFields.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import Foundation
import UIKit

enum MarketDataField: Int, Codable, CaseIterable {
    
    /// Order to place on sorting
    static let rawOrder: [MarketDataField] = [revenueGrowthYoy, enterpriseValueToSales, marketCapitalization, priceChange1m, profitMargin]
    
    /// Default metrics for ticker details
    static let metricsOrder: [MarketDataField] = [revenueGrowthYoy, enterpriseValueToSales, marketCapitalization, priceChange1m, profitMargin]
    
    case
    
    // MATCH SCORE
    matchScore = 0,
    
    // TRADING
    avgVolume10d, // avg_volume_10d
    sharesOutstanding, // shares_outstanding
    shortPercentOutstanding, // short_percent
    avgVolume90d, // avg_volume_90d
    sharesFloat, // shares_float
    shortRatio, // short_ratio
    beta, // beta
    impliedVolatility, // implied_volatility,
    //absolute_historical_volatility_adjusted_current
    //relative_historical_volatility_adjusted_current
    //absolute_historical_volatility_adjusted_min_1y
    //absolute_historical_volatility_adjusted_max_1y
    //relative_historical_volatility_adjusted_min_1y
    //relative_historical_volatility_adjusted_max_1y
    
    // GROWTH
    revenueGrowthYoy, // revenue_growth_yoy
    revenueGrowthFwd, // revenue_growth_fwd
    ebitdaGrowthYoy, // ebitda_growth_yoy
    // ebitda_growth_fwd - not ready yet: we don't have ebitda estimations
    epsGrowthYoy, // eps_growth_yoy
    epsGrowthFwd, // eps_growth_fwd
    
    // GENERAL
    // Full time employees - no data for now
    // Total employees - no data for now
    address, //
    // address_city,
    // address_state,
    // address_county,
    // address_full,
    exchangeName, // exchange_name
         
    // VALUATION
    marketCapitalization, // market_capitalization
    enterpriseValueToSales, // enterprise_value_to_sales
    priceToEarningsTtm, // price_to_earnings_ttm
    priceToSalesTtm, // price_to_sales_ttm
    priceToBookValue, // price_to_book_value
    enterpriseValueToEbitda, // enterprise_value_to_ebitda
    
    // MOMENTUM
    priceChange1m, // price_change_1m
    priceChange3m, // price_change_3m
    priceChange1y, // price_change_1y
    
    // DIVIDEND
    dividendYield, // dividend_yield
    dividendsPerShare, // dividends_per_share
    dividendPayoutRatio, // dividend_payout_ratio
    yearsOfConsecutiveDividendGrowth, // years_of_consecutive_dividend_growth
    dividendFrequency, // dividend_frequency
    
    // EARNINGS
    epsActual, // eps_actual
    epsEstimate, // eps_estimate
    beatenQuarterlyEpsEstimationCountTtm, // beaten_quarterly_eps_estimation_count_ttm
    epsSurprise, // eps_surprise
    revenueEstimateAvg0y, // revenue_estimate_avg_0y
    revenueActual, // revenue_actual
    
    // FINANCIALS
    revenueTtm, // revenue_ttm
    revenuePerShareTtm, // revenue_per_share_ttm
    roi, // roi
    netIncome, // net_income
    assetCashAndEquivalents, // asset_cash_and_equivalents
    roa, // roa
    totalAssets, // total_assets
    ebitda, // ebitda
    profitMargin, // profit_margin
    netDebt // net_de
    
    func mapToMarketData(ticker: RemoteTicker) -> TickerInfo.MarketData? {
        
        var marketData: TickerInfo.MarketData? = nil
        
        switch self {
        case .avgVolume10d:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "10 DAYS", value: Float(ticker.tickerMetrics?.avgVolume_10d ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .sharesOutstanding:
            var valueString = Float(ticker.tickerMetrics?.sharesOutstanding ?? 0).formatUsingAbbrevation(false)
            if ticker.tickerMetrics?.sharesOutstanding == nil {
                valueString = "null"
            }
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: valueString, marketDataField: self)
        case .shortPercentOutstanding:
            var valueString = (Float(ticker.tickerMetrics?.shortPercentOutstanding ?? 0.0) * 100.0).cleanOneDecimalP
            if ticker.tickerMetrics?.shortPercentOutstanding == nil {
                valueString = "null"
            }
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:valueString , marketDataField: self)
        case .avgVolume90d:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "90 DAYS", value: Float(ticker.tickerMetrics?.avgVolume_90d ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .sharesFloat:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.sharesFloat ?? 0).formatUsingAbbrevation(false), marketDataField: self)
        case .shortRatio:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.shortRatio ?? 0).formatUsingAbbrevation(false), marketDataField: self)
        case .beta:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.beta ?? 0).formatUsingAbbrevation(false), marketDataField: self)
        case .impliedVolatility:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.impliedVolatility ?? 0).zeroDecimalP, marketDataField: self)
        case .revenueGrowthYoy:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "QUarterly, YoY", value: (Float(ticker.tickerMetrics?.revenueGrowthYoy ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .revenueGrowthFwd:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "QUarterly, FWD", value: (Float(ticker.tickerMetrics?.revenueGrowthFwd ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .ebitdaGrowthYoy:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "QUarterly, YoY", value: (Float(ticker.tickerMetrics?.ebitdaGrowthYoy ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .epsGrowthYoy:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "QUarterly, YoY", value: (Float(ticker.tickerMetrics?.epsGrowthYoy ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .epsGrowthFwd:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "QUarterly, FWD", value: (Float(ticker.tickerMetrics?.epsGrowthFwd ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
            
        case .address:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:ticker.tickerMetrics?.addressCity ?? "", marketDataField: self)
        case .exchangeName:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:ticker.tickerMetrics?.exchangeName ?? "", marketDataField: self)
            
        
        case .marketCapitalization:
            let value = ticker.tickerMetrics?.marketCapitalization != nil ? Double(ticker.tickerMetrics!.marketCapitalization!) : 0.0
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:value.formatUsingAbbrevation(), marketDataField: self)
        case .enterpriseValueToSales:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.enterpriseValueToSales ?? 0.0).formatUsingAbbrevation(false), marketDataField: self)
        case .priceToEarningsTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.priceToEarningsTtm ?? 0.0).cleanOneDecimal, marketDataField: self)
        case .priceToSalesTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.priceToSalesTtm ?? 0.0).formatUsingAbbrevation(false), marketDataField: self)
        case .priceToBookValue:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.priceToBookValue ?? 0.0).cleanOneDecimal, marketDataField: self)
        case .enterpriseValueToEbitda:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0).formatUsingAbbrevation(false), marketDataField: self)
            
        case .priceChange1m:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: (Float(ticker.tickerMetrics?.priceChange_1m ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .priceChange3m:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: (Float(ticker.tickerMetrics?.priceChange_3m ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .priceChange1y:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: (Float(ticker.tickerMetrics?.priceChange_1y ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
            
            
        case .dividendYield:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: (Float(ticker.tickerMetrics?.dividendYield ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .dividendsPerShare:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.dividendsPerShare ?? 0.0).cleanOneDecimal, marketDataField: self)
        case .dividendPayoutRatio:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM, GAAP", value: (Float(ticker.tickerMetrics?.dividendPayoutRatio ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .yearsOfConsecutiveDividendGrowth:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.yearsOfConsecutiveDividendGrowth ?? 0).cleanOneDecimal, marketDataField: self)
        case .dividendFrequency:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: ticker.tickerMetrics?.dividendFrequency ?? "", marketDataField: self)
            
        case .epsActual:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: " Non-GAAP", value: Float(ticker.tickerMetrics?.epsActual ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .epsEstimate:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.epsEstimate ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .beatenQuarterlyEpsEstimationCountTtm:
            var valueString = "None"
            if let value = ticker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm {
                valueString = "{" + Float(value).cleanOneDecimal + "} / 4"
            }
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:valueString, marketDataField: self)
        case .epsSurprise:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "Beats or Misses by", value: Float(ticker.tickerMetrics?.epsSurprise ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenueEstimateAvg0y:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "annual", value: Float(ticker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenueActual:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.revenueActual ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
            
        case .revenueTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.revenueTtm ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenuePerShareTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.revenuePerShareTtm ?? 0.0).price, marketDataField: self)
        case .roi:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:  (ticker.tickerMetrics?.roi ?? 0.0).percent, marketDataField: self)
        case .netIncome:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.netIncome ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .assetCashAndEquivalents:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.assetCashAndEquivalents ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .roa:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value:  (ticker.tickerMetrics?.roa ?? 0.0).percent, marketDataField: self)
        case .totalAssets:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.totalAssets ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .ebitda:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.ebitda ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .profitMargin:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.profitMargin ?? 0.0).percent, marketDataField: self)
        case .netDebt:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.netDebt ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        
        default:
            break
        }
        
        return marketData
    }
    
    var title: String {
        switch self {
        case .matchScore:
            return "Match Score"
        case .avgVolume10d:
            return "Avg Volume, 10 days"
        case .sharesOutstanding:
            return "Shares Outstanding"
        case .shortPercentOutstanding:
            return "Short of Outstanding Stocks"
        case .avgVolume90d:
            return "Avg Volume, 90 days"
        case .sharesFloat:
            return "Shares Float"
        case .shortRatio:
            return "Short Ratio"
        case .beta:
            return "beta"
        case .impliedVolatility:
            return "Implied Volatility Current"
        case .revenueGrowthYoy:
            return "Revenue Growth, TTM"
        case .revenueGrowthFwd:
            return "Revenue Growth, FWD"
        case .ebitdaGrowthYoy:
            return "EBITDA Growth, TTM"
        case .epsGrowthYoy:
            return "EPS Growth, TTM"
        case .epsGrowthFwd:
            return "EPS Growth, FWD"
        case .address:
            return "Company HQ location"
        case .exchangeName:
            return "Exchange name"
        case .marketCapitalization:
            return "Market Capitalization"
        case .enterpriseValueToSales:
            return "EV / Sales, TTM"
        case .priceToEarningsTtm:
            return "PE, TTM"
        case .priceToSalesTtm:
            return "Price / Sales, TTM"
        case .priceToBookValue:
            return "Price / Book, TTM "
        case .enterpriseValueToEbitda:
            return "EV / EBITDA, TTM"
        case .priceChange1m:
            return "30 days price change"
        case .priceChange3m:
            return "90 days price change"
        case .priceChange1y:
            return "1 year price change"
        case .dividendYield:
            return "Dividend yield"
        case .dividendsPerShare:
            return "Dividends per Share"
        case .dividendPayoutRatio:
            return "Dividend Payout Ratio"
        case .yearsOfConsecutiveDividendGrowth:
            return "Years of dividend growth"
        case .dividendFrequency:
            return "Dividend Frequency"
        case .epsActual:
            return "EPS Actual"
        case .epsEstimate:
            return "EPS Estimate"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "Beaten expectations"
        case .epsSurprise:
            return "EPS Surprise"
        case .revenueEstimateAvg0y:
            return "Next Revenue Estimate"
        case .revenueActual:
            return "Revenue Actual"
        case .revenueTtm:
            return "Revenues"
        case .revenuePerShareTtm:
            return "Revenue Per share"
        case .roi:
            return "ROI"
        case .netIncome:
            return "Net income"
        case .assetCashAndEquivalents:
            return "Cash and Equivalents"
        case .roa:
            return "ROA"
        case .totalAssets:
            return "Total Assets"
        case .ebitda:
            return "EBITDA"
        case .profitMargin:
            return "Net Profit Margin"
        case .netDebt:
            return "Total Debt"
        }
    }
    
    var shortTitle: String {
        switch self {
        case .matchScore:
            return Constants.CollectionDetails.matchScore
        case .avgVolume10d:
            return "Avg Vol\n10 days"
        case .sharesOutstanding:
            return "Shares\nOutstanding"
        case .shortPercentOutstanding:
            return "Short of\nOutstanding Stocks"
        case .avgVolume90d:
            return "Avg Vol,\n90 days"
        case .sharesFloat:
            return "Shares\nFloat"
        case .shortRatio:
            return "Short\nRatio"
        case .beta:
            return "beta"
        case .impliedVolatility:
            return "Implied Volatility\nCurrent"
        case .revenueGrowthYoy:
            return "Revenue\nGrowth"
        case .revenueGrowthFwd:
            return "Revenue\nGrowth"
        case .ebitdaGrowthYoy:
            return "EBITDA\nGrowth"
        case .epsGrowthYoy:
            return "EPS\nGrowth, TTM"
        case .epsGrowthFwd:
            return "EPS\nGrowth, FWD"
        case .address:
            return "Company HQ\nlocation"
        case .exchangeName:
            return "Exchange\nname"
        case .marketCapitalization:
            return "Market\nCap"
        case .enterpriseValueToSales:
            return "EV/S,\nTTM"
        case .priceToEarningsTtm:
            return "PE,\nTTM"
        case .priceToSalesTtm:
            return "Price/Sales,\nTTM"
        case .priceToBookValue:
            return "Price/Book,\nTTM"
        case .enterpriseValueToEbitda:
            return "EV / EBITDA,\nTTM"
        case .priceChange1m:
            return "30d price\nchange"
        case .priceChange3m:
            return "90d price\nchange"
        case .priceChange1y:
            return "1y price\nchange"
        case .dividendYield:
            return "Dividend\nyield"
        case .dividendsPerShare:
            return "Dividends / \nShare"
        case .dividendPayoutRatio:
            return "Dividend Payout\nRatio"
        case .yearsOfConsecutiveDividendGrowth:
            return "Years of\ndividend growth"
        case .dividendFrequency:
            return "Dividend\nFrequency"
        case .epsActual:
            return "EPS\nActual"
        case .epsEstimate:
            return "EPS\nEstimate"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "Beaten\nexpectations"
        case .epsSurprise:
            return "EPS\nSurprise"
        case .revenueEstimateAvg0y:
            return "Next Revenue\nEstimate"
        case .revenueActual:
            return "Revenue\nActual"
        case .revenueTtm:
            return "Revenues"
        case .revenuePerShareTtm:
            return "Revenue / \nShare"
        case .roi:
            return "ROI"
        case .netIncome:
            return "Net\nincome"
        case .assetCashAndEquivalents:
            return "Cash and\nEquivalents"
        case .roa:
            return "ROA"
        case .totalAssets:
            return "Total\nAssets"
        case .ebitda:
            return "EBITDA"
        case .profitMargin:
            return "Net\nProfit"
        case .netDebt:
            return "Total\nDebt"
        }
    }
    
    var fieldName: String {
        switch self {
        case .matchScore:
            return "none"
        case .avgVolume10d:
            return "avg_volume_10d"
        case .sharesOutstanding:
            return "shares_outstanding"
        case .shortPercentOutstanding:
            return "short_percent"
        case .avgVolume90d:
            return "avg_volume_90d"
        case .sharesFloat:
            return "shares_float"
        case .shortRatio:
            return "short_ratio"
        case .beta:
            return "beta"
        case .impliedVolatility:
            return "implied_volatility"
        case .revenueGrowthYoy:
            return "revenue_growth_yoy"
        case .revenueGrowthFwd:
            return "revenue_growth_fwd"
        case .ebitdaGrowthYoy:
            return "ebitda_growth_yoy"
        case .epsGrowthYoy:
            return "eps_growth_yoy"
        case .epsGrowthFwd:
            return "eps_growth_fwd"
        case .address:
            return "address_city"
        case .exchangeName:
            return "exchange_name"
        case .marketCapitalization:
            return "market_capitalization"
        case .enterpriseValueToSales:
            return "enterprise_value_to_sales"
        case .priceToEarningsTtm:
            return "price_to_earnings_ttm"
        case .priceToSalesTtm:
            return "price_to_sales_ttm"
        case .priceToBookValue:
            return "price_to_book_value"
        case .enterpriseValueToEbitda:
            return "enterprise_value_to_ebitda"
        case .priceChange1m:
            return "price_change_1m"
        case .priceChange3m:
            return "price_change_3m"
        case .priceChange1y:
            return "price_change_1y"
        case .dividendYield:
            return "dividend_yield"
        case .dividendsPerShare:
            return "dividends_per_share"
        case .dividendPayoutRatio:
            return "dividend_payout_ratio"
        case .yearsOfConsecutiveDividendGrowth:
            return "years_of_consecutive_dividend_growth"
        case .dividendFrequency:
            return "dividend_frequency"
        case .epsActual:
            return "eps_actual"
        case .epsEstimate:
            return "eps_estimate"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "beaten_quarterly_eps_estimation_count_ttm"
        case .epsSurprise:
            return "eps_difference"
        case .revenueEstimateAvg0y:
            return "revenue_estimate_avg_0y"
        case .revenueActual:
            return "revenue_actual"
        case .revenueTtm:
            return "revenue_ttm"
        case .revenuePerShareTtm:
            return "revenue_per_share_ttm"
        case .roi:
            return "roi"
        case .netIncome:
            return "net_income_ttm"
        case .assetCashAndEquivalents:
            return "asset_cash_and_equivalents"
        case .roa:
            return "roa"
        case .totalAssets:
            return "total_assets"
        case .ebitda:
            return "ebitda_ttm"
        case .profitMargin:
            return "profit_margin"
        case .netDebt:
            return "net_debt"
        }
    }
    
    var isPercent: Bool {
        switch self {
        case .matchScore:
            return false
        case .avgVolume10d:
            return false
        case .sharesOutstanding:
            return false
        case .shortPercentOutstanding:
            return true
        case .avgVolume90d:
            return false
        case .sharesFloat:
            return false
        case .shortRatio:
            return false
        case .beta:
            return false
        case .impliedVolatility:
            return true
        case .revenueGrowthYoy:
            return true
        case .revenueGrowthFwd:
            return true
        case .ebitdaGrowthYoy:
            return true
        case .epsGrowthYoy:
            return true
        case .epsGrowthFwd:
            return true
        case .address:
            return false
        case .exchangeName:
            return false
        case .marketCapitalization:
            return false
        case .enterpriseValueToSales:
            return false
        case .priceToEarningsTtm:
            return false
        case .priceToSalesTtm:
            return false
        case .priceToBookValue:
            return false
        case .enterpriseValueToEbitda:
            return false
        case .priceChange1m:
            return true
        case .priceChange3m:
            return true
        case .priceChange1y:
            return true
        case .dividendYield:
            return true
        case .dividendsPerShare:
            return false
        case .dividendPayoutRatio:
            return true
        case .yearsOfConsecutiveDividendGrowth:
            return false
        case .dividendFrequency:
            return false
        case .epsActual:
            return false
        case .epsEstimate:
            return false
        case .beatenQuarterlyEpsEstimationCountTtm:
            return false
        case .epsSurprise:
            return false
        case .revenueEstimateAvg0y:
            return false
        case .revenueActual:
            return false
        case .revenueTtm:
            return false
        case .revenuePerShareTtm:
            return false
        case .roi:
            return false
        case .netIncome:
            return false
        case .assetCashAndEquivalents:
            return false
        case .roa:
            return false
        case .totalAssets:
            return false
        case .ebitda:
            return false
        case .profitMargin:
            return true
        case .netDebt:
            return false
        }
    }
    
    func sortFunc (isAsc: Bool, _ lhs: CollectionCardViewCellModel, _ rhs: CollectionCardViewCellModel) -> Bool {
        
        if isAsc {
            switch self {
            case .matchScore:
                return (lhs.rawTicker.matchScore?.matchScore ?? 0) < (rhs.rawTicker.matchScore?.matchScore ?? 0)
            case .sharesOutstanding:
                return (lhs.rawTicker.tickerMetrics?.sharesOutstanding ?? 0) < (rhs.rawTicker.tickerMetrics?.sharesOutstanding ?? 0)
            case .shortPercentOutstanding:
                return (lhs.rawTicker.tickerMetrics?.shortPercentOutstanding ?? 0.0) < (rhs.rawTicker.tickerMetrics?.shortPercentOutstanding ?? 0.0)
            case .avgVolume10d:
                return (lhs.rawTicker.tickerMetrics?.avgVolume_10d ?? 0.0) < (rhs.rawTicker.tickerMetrics?.avgVolume_10d ?? 0.0)
            case .avgVolume90d:
                return (lhs.rawTicker.tickerMetrics?.avgVolume_90d ?? 0.0) < (rhs.rawTicker.tickerMetrics?.avgVolume_90d ?? 0.0)
            case .sharesFloat:
                return (lhs.rawTicker.tickerMetrics?.sharesFloat ?? 0) < (rhs.rawTicker.tickerMetrics?.sharesFloat ?? 0)
            case .shortRatio:
                return (lhs.rawTicker.tickerMetrics?.shortRatio ?? 0.0) < (rhs.rawTicker.tickerMetrics?.shortRatio ?? 0.0)
            case .beta:
                return (lhs.rawTicker.tickerMetrics?.beta ?? 0.0) < (rhs.rawTicker.tickerMetrics?.beta ?? 0.0)
            case .impliedVolatility:
                return (lhs.rawTicker.tickerMetrics?.impliedVolatility ?? 0.0) < (rhs.rawTicker.tickerMetrics?.impliedVolatility ?? 0.0)
            case .revenueGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.revenueGrowthYoy ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenueGrowthYoy ?? 0.0)
            case .revenueGrowthFwd:
                return (lhs.rawTicker.tickerMetrics?.revenueGrowthFwd ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenueGrowthFwd ?? 0.0)
            case .ebitdaGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.ebitdaGrowthYoy ?? 0.0) < (rhs.rawTicker.tickerMetrics?.ebitdaGrowthYoy ?? 0.0)
            case .epsGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.epsGrowthYoy ?? 0.0) < (rhs.rawTicker.tickerMetrics?.epsGrowthYoy ?? 0.0)
            case .epsGrowthFwd:
                return (lhs.rawTicker.tickerMetrics?.epsGrowthFwd ?? 0.0) < (rhs.rawTicker.tickerMetrics?.epsGrowthFwd ?? 0.0)
            case .address:
                return (lhs.rawTicker.tickerMetrics?.addressCity ?? "") < (rhs.rawTicker.tickerMetrics?.addressCity ?? "")
            case .exchangeName:
                return (lhs.rawTicker.tickerMetrics?.exchangeName ?? "") < (rhs.rawTicker.tickerMetrics?.exchangeName ?? "")
            case .marketCapitalization:
                return (lhs.rawTicker.tickerMetrics?.marketCapitalization ?? 0) < (rhs.rawTicker.tickerMetrics?.marketCapitalization ?? 0)
            case .enterpriseValueToSales:
                return (lhs.rawTicker.tickerMetrics?.enterpriseValueToSales ?? 0.0) < (rhs.rawTicker.tickerMetrics?.enterpriseValueToSales ?? 0.0)
            case .priceToEarningsTtm:
                return (lhs.rawTicker.tickerMetrics?.priceToEarningsTtm ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceToEarningsTtm ?? 0.0)
            case .priceToSalesTtm:
                return (lhs.rawTicker.tickerMetrics?.priceToSalesTtm ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceToSalesTtm ?? 0.0)
            case .priceToBookValue:
                return (lhs.rawTicker.tickerMetrics?.priceToBookValue ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceToBookValue ?? 0.0)
            case .enterpriseValueToEbitda:
                return (lhs.rawTicker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0) < (rhs.rawTicker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0)
            case .priceChange1m:
                return (lhs.rawTicker.tickerMetrics?.priceChange_1m ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceChange_1m ?? 0.0)
            case .priceChange3m:
                return (lhs.rawTicker.tickerMetrics?.priceChange_3m ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceChange_3m ?? 0.0)
            case .priceChange1y:
                return (lhs.rawTicker.tickerMetrics?.priceChange_1y ?? 0.0) < (rhs.rawTicker.tickerMetrics?.priceChange_1y ?? 0.0)
            case .dividendYield:
                return (lhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0) < (rhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0)
            case .dividendsPerShare:
                return (lhs.rawTicker.tickerMetrics?.dividendsPerShare ?? 0.0) < (rhs.rawTicker.tickerMetrics?.dividendsPerShare ?? 0.0)
            case .dividendPayoutRatio:
                return (lhs.rawTicker.tickerMetrics?.dividendPayoutRatio ?? 0.0) < (rhs.rawTicker.tickerMetrics?.dividendPayoutRatio ?? 0.0)
            case .yearsOfConsecutiveDividendGrowth:
                return (lhs.rawTicker.tickerMetrics?.yearsOfConsecutiveDividendGrowth ?? 0) < (rhs.rawTicker.tickerMetrics?.yearsOfConsecutiveDividendGrowth ?? 0)
            case .dividendFrequency:
                return (lhs.rawTicker.tickerMetrics?.dividendFrequency ?? "") < (rhs.rawTicker.tickerMetrics?.dividendFrequency ?? "")
            case .epsActual:
                return (lhs.rawTicker.tickerMetrics?.epsActual ?? 0.0) < (rhs.rawTicker.tickerMetrics?.epsActual ?? 0.0)
            case .epsEstimate:
                return (lhs.rawTicker.tickerMetrics?.epsEstimate ?? 0.0) < (rhs.rawTicker.tickerMetrics?.epsEstimate ?? 0.0)
            case .beatenQuarterlyEpsEstimationCountTtm:
                return (lhs.rawTicker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm ?? 0) < (rhs.rawTicker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm ?? 0)
            case .epsSurprise:
                return (lhs.rawTicker.tickerMetrics?.epsSurprise ?? 0.0) < (rhs.rawTicker.tickerMetrics?.epsSurprise ?? 0.0)
            case .revenueEstimateAvg0y:
                return (lhs.rawTicker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0)
            case .revenueActual:
                return (lhs.rawTicker.tickerMetrics?.revenueActual ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenueActual ?? 0.0)
            case .revenueTtm:
                return (lhs.rawTicker.tickerMetrics?.revenueTtm ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenueTtm ?? 0.0)
            case .revenuePerShareTtm:
                return (lhs.rawTicker.tickerMetrics?.revenuePerShareTtm ?? 0.0) < (rhs.rawTicker.tickerMetrics?.revenuePerShareTtm ?? 0.0)
            case .roi:
                return (lhs.rawTicker.tickerMetrics?.roi ?? 0.0) < (rhs.rawTicker.tickerMetrics?.roi ?? 0.0)
            case .netIncome:
                return (lhs.rawTicker.tickerMetrics?.netIncome ?? 0.0) < (rhs.rawTicker.tickerMetrics?.netIncome ?? 0.0)
            case .assetCashAndEquivalents:
                return (lhs.rawTicker.tickerMetrics?.assetCashAndEquivalents ?? 0.0) < (rhs.rawTicker.tickerMetrics?.assetCashAndEquivalents ?? 0.0)
            case .roa:
                return (lhs.rawTicker.tickerMetrics?.roa ?? 0.0) < (rhs.rawTicker.tickerMetrics?.roa ?? 0.0)
            case .totalAssets:
                return (lhs.rawTicker.tickerMetrics?.totalAssets ?? 0.0) < (rhs.rawTicker.tickerMetrics?.totalAssets ?? 0.0)
            case .ebitda:
                return (lhs.rawTicker.tickerMetrics?.ebitda ?? 0.0) < (rhs.rawTicker.tickerMetrics?.ebitda ?? 0.0)
            case .profitMargin:
                return (lhs.rawTicker.tickerMetrics?.profitMargin ?? 0.0) < (rhs.rawTicker.tickerMetrics?.profitMargin ?? 0.0)
            case .netDebt:
                return (lhs.rawTicker.tickerMetrics?.netDebt ?? 0.0) < (rhs.rawTicker.tickerMetrics?.netDebt ?? 0.0)
            }
        } else {
            switch self {
            case .matchScore:
                return (lhs.rawTicker.matchScore?.matchScore ?? 0) > (rhs.rawTicker.matchScore?.matchScore ?? 0)
            case .sharesOutstanding:
                return (lhs.rawTicker.tickerMetrics?.sharesOutstanding ?? 0) > (rhs.rawTicker.tickerMetrics?.sharesOutstanding ?? 0)
            case .shortPercentOutstanding:
                return (lhs.rawTicker.tickerMetrics?.shortPercentOutstanding ?? 0.0) > (rhs.rawTicker.tickerMetrics?.shortPercentOutstanding ?? 0.0)
            case .avgVolume10d:
                return (lhs.rawTicker.tickerMetrics?.avgVolume_10d ?? 0.0) > (rhs.rawTicker.tickerMetrics?.avgVolume_10d ?? 0.0)
            case .avgVolume90d:
                return (lhs.rawTicker.tickerMetrics?.avgVolume_90d ?? 0.0) > (rhs.rawTicker.tickerMetrics?.avgVolume_90d ?? 0.0)
            case .sharesFloat:
                return (lhs.rawTicker.tickerMetrics?.sharesFloat ?? 0) > (rhs.rawTicker.tickerMetrics?.sharesFloat ?? 0)
            case .shortRatio:
                return (lhs.rawTicker.tickerMetrics?.shortRatio ?? 0.0) > (rhs.rawTicker.tickerMetrics?.shortRatio ?? 0.0)
            case .beta:
                return (lhs.rawTicker.tickerMetrics?.beta ?? 0.0) > (rhs.rawTicker.tickerMetrics?.beta ?? 0.0)
            case .impliedVolatility:
                return (lhs.rawTicker.tickerMetrics?.impliedVolatility ?? 0.0) > (rhs.rawTicker.tickerMetrics?.impliedVolatility ?? 0.0)
            case .revenueGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.revenueGrowthYoy ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenueGrowthYoy ?? 0.0)
            case .revenueGrowthFwd:
                return (lhs.rawTicker.tickerMetrics?.revenueGrowthFwd ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenueGrowthFwd ?? 0.0)
            case .ebitdaGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.ebitdaGrowthYoy ?? 0.0) > (rhs.rawTicker.tickerMetrics?.ebitdaGrowthYoy ?? 0.0)
            case .epsGrowthYoy:
                return (lhs.rawTicker.tickerMetrics?.epsGrowthYoy ?? 0.0) > (rhs.rawTicker.tickerMetrics?.epsGrowthYoy ?? 0.0)
            case .epsGrowthFwd:
                return (lhs.rawTicker.tickerMetrics?.epsGrowthFwd ?? 0.0) > (rhs.rawTicker.tickerMetrics?.epsGrowthFwd ?? 0.0)
            case .address:
                return (lhs.rawTicker.tickerMetrics?.addressCity ?? "") > (rhs.rawTicker.tickerMetrics?.addressCity ?? "")
            case .exchangeName:
                return (lhs.rawTicker.tickerMetrics?.exchangeName ?? "") > (rhs.rawTicker.tickerMetrics?.exchangeName ?? "")
            case .marketCapitalization:
                return (lhs.rawTicker.tickerMetrics?.marketCapitalization ?? 0) > (rhs.rawTicker.tickerMetrics?.marketCapitalization ?? 0)
            case .enterpriseValueToSales:
                return (lhs.rawTicker.tickerMetrics?.enterpriseValueToSales ?? 0.0) > (rhs.rawTicker.tickerMetrics?.enterpriseValueToSales ?? 0.0)
            case .priceToEarningsTtm:
                return (lhs.rawTicker.tickerMetrics?.priceToEarningsTtm ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceToEarningsTtm ?? 0.0)
            case .priceToSalesTtm:
                return (lhs.rawTicker.tickerMetrics?.priceToSalesTtm ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceToSalesTtm ?? 0.0)
            case .priceToBookValue:
                return (lhs.rawTicker.tickerMetrics?.priceToBookValue ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceToBookValue ?? 0.0)
            case .enterpriseValueToEbitda:
                return (lhs.rawTicker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0) > (rhs.rawTicker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0)
            case .priceChange1m:
                return (lhs.rawTicker.tickerMetrics?.priceChange_1m ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceChange_1m ?? 0.0)
            case .priceChange3m:
                return (lhs.rawTicker.tickerMetrics?.priceChange_3m ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceChange_3m ?? 0.0)
            case .priceChange1y:
                return (lhs.rawTicker.tickerMetrics?.priceChange_1y ?? 0.0) > (rhs.rawTicker.tickerMetrics?.priceChange_1y ?? 0.0)
            case .dividendYield:
                return (lhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0) > (rhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0)
            case .dividendsPerShare:
                return (lhs.rawTicker.tickerMetrics?.dividendsPerShare ?? 0.0) > (rhs.rawTicker.tickerMetrics?.dividendsPerShare ?? 0.0)
            case .dividendPayoutRatio:
                return (lhs.rawTicker.tickerMetrics?.dividendPayoutRatio ?? 0.0) > (rhs.rawTicker.tickerMetrics?.dividendPayoutRatio ?? 0.0)
            case .yearsOfConsecutiveDividendGrowth:
                return (lhs.rawTicker.tickerMetrics?.yearsOfConsecutiveDividendGrowth ?? 0) > (rhs.rawTicker.tickerMetrics?.yearsOfConsecutiveDividendGrowth ?? 0)
            case .dividendFrequency:
                return (lhs.rawTicker.tickerMetrics?.dividendFrequency ?? "") > (rhs.rawTicker.tickerMetrics?.dividendFrequency ?? "")
            case .epsActual:
                return (lhs.rawTicker.tickerMetrics?.epsActual ?? 0.0) > (rhs.rawTicker.tickerMetrics?.epsActual ?? 0.0)
            case .epsEstimate:
                return (lhs.rawTicker.tickerMetrics?.epsEstimate ?? 0.0) > (rhs.rawTicker.tickerMetrics?.epsEstimate ?? 0.0)
            case .beatenQuarterlyEpsEstimationCountTtm:
                return (lhs.rawTicker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm ?? 0) > (rhs.rawTicker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm ?? 0)
            case .epsSurprise:
                return (lhs.rawTicker.tickerMetrics?.epsSurprise ?? 0.0) > (rhs.rawTicker.tickerMetrics?.epsSurprise ?? 0.0)
            case .revenueEstimateAvg0y:
                return (lhs.rawTicker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0)
            case .revenueActual:
                return (lhs.rawTicker.tickerMetrics?.revenueActual ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenueActual ?? 0.0)
            case .revenueTtm:
                return (lhs.rawTicker.tickerMetrics?.revenueTtm ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenueTtm ?? 0.0)
            case .revenuePerShareTtm:
                return (lhs.rawTicker.tickerMetrics?.revenuePerShareTtm ?? 0.0) > (rhs.rawTicker.tickerMetrics?.revenuePerShareTtm ?? 0.0)
            case .roi:
                return (lhs.rawTicker.tickerMetrics?.roi ?? 0.0) > (rhs.rawTicker.tickerMetrics?.roi ?? 0.0)
            case .netIncome:
                return (lhs.rawTicker.tickerMetrics?.netIncome ?? 0.0) > (rhs.rawTicker.tickerMetrics?.netIncome ?? 0.0)
            case .assetCashAndEquivalents:
                return (lhs.rawTicker.tickerMetrics?.assetCashAndEquivalents ?? 0.0) > (rhs.rawTicker.tickerMetrics?.assetCashAndEquivalents ?? 0.0)
            case .roa:
                return (lhs.rawTicker.tickerMetrics?.roa ?? 0.0) > (rhs.rawTicker.tickerMetrics?.roa ?? 0.0)
            case .totalAssets:
                return (lhs.rawTicker.tickerMetrics?.totalAssets ?? 0.0) > (rhs.rawTicker.tickerMetrics?.totalAssets ?? 0.0)
            case .ebitda:
                return (lhs.rawTicker.tickerMetrics?.ebitda ?? 0.0) > (rhs.rawTicker.tickerMetrics?.ebitda ?? 0.0)
            case .profitMargin:
                return (lhs.rawTicker.tickerMetrics?.profitMargin ?? 0.0) > (rhs.rawTicker.tickerMetrics?.profitMargin ?? 0.0)
            case .netDebt:
                return (lhs.rawTicker.tickerMetrics?.netDebt ?? 0.0) > (rhs.rawTicker.tickerMetrics?.netDebt ?? 0.0)
            }
        }
    }
     
    var explanationTitle: String {
        switch self {
        case .matchScore:
            return "Profile matching score"
        case .avgVolume10d:
            return "Trading volume"
        case .sharesOutstanding:
            return "Shares Outstanding"
        case .shortPercentOutstanding:
            return "Short of Outstanding Stocks"
        case .avgVolume90d:
            return "Average Trading volume over last 90 days"
        case .sharesFloat:
            return "Shares Float"
        case .shortRatio:
            return "Short Ratio"
        case .beta:
            return "beta"
        case .impliedVolatility:
            return "Implied Volatility Current"
        case .revenueGrowthYoy:
            return "Quarterly Revenue Growth, Year over Year over last 12 trailing months"
        case .revenueGrowthFwd:
            return "Quarterly Revenue Growth, Year over Year forward"
        case .ebitdaGrowthYoy:
            return "Earnings Before Interest, Taxes, Depreciation, and Amortization over the last trailing 12 months"
        case .epsGrowthYoy:
            return "The growth of earnings per share over the last trailing 12 months"
        case .epsGrowthFwd:
            return "The growth of earnings per share over for the future quarter based on earning estimates"
        case .address:
            return "Company HQ location"
        case .exchangeName:
            return "Exchange name"
        case .marketCapitalization:
            return "Market Capitalization"
        case .enterpriseValueToSales:
            return "Enterprise Value-to-Sales over last 12 trailing months"
        case .priceToEarningsTtm:
            return "Price-to-Earnings (P/E) Ratio based on 12 trailing months data"
        case .priceToSalesTtm:
            return "Price-to-Sales (P/S) Ratio based on 12 trailing months data"
        case .priceToBookValue:
            return "Price-To-Book based on 12 trailing months data"
        case .enterpriseValueToEbitda:
            return "Enterprise Multiple based on 12 trailing months data"
        case .priceChange1m:
            return "30 days price change"
        case .priceChange3m:
            return "90 days price change"
        case .priceChange1y:
            return "1 year price change"
        case .dividendYield:
            return "Dividend yield"
        case .dividendsPerShare:
            return "Dividends per Share"
        case .dividendPayoutRatio:
            return "Dividend Payout Ratio"
        case .yearsOfConsecutiveDividendGrowth:
            return "Years of dividend growth"
        case .dividendFrequency:
            return "Dividend Frequency"
        case .epsActual:
            return "Primary Earnings Per Share (EPS)"
        case .epsEstimate:
            return "Estimate for Primary Earnings Per Share (EPS) based on last earnings results"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "Beaten expectations"
        case .epsSurprise:
            return "EPS Surprise"
        case .revenueEstimateAvg0y:
            return "Next Earnings Revenue Estimate"
        case .revenueActual:
            return "Revenue Actual"
        case .revenueTtm:
            return "Revenues"
        case .revenuePerShareTtm:
            return "Revenue Per share"
        case .roi:
            return "Return on Investment (ROI)"
        case .netIncome:
            return "Net income"
        case .assetCashAndEquivalents:
            return "Cash And Cash Equivalents (CCE)"
        case .roa:
            return "Return on Assets (ROA)"
        case .totalAssets:
            return "Total Assets"
        case .ebitda:
            return "Earnings Before Interest, Taxes, Depreciation, and Amortization"
        case .profitMargin:
            return "Net Profit Margin"
        case .netDebt:
            return "Total Debt / Net debt"
        }
    }
    
    var explanationDescription: String {
        switch self {
        case .matchScore:
            return "This metric is built based on your profile. We use data like your investments goals, risk profile, investment interests and existing portfolio."
        case .avgVolume10d:
            return "Trading volume is a measure of how much of a given financial asset has traded in a period of time. For stocks, volume is measured in the number of shares traded and, for futures and options, it is based on how many contracts have changed hands. Read more on Investopedia."
        case .sharesOutstanding:
            return "Shares outstanding refer to a company's stock currently held by all its shareholders. Read more on Investopedia."
        case .shortPercentOutstanding:
            return "How much this stock is shorted on the market today. Read more on Investopedia."
        case .avgVolume90d:
            return "Trading volume is a measure of how much of a given financial asset has traded in a period of time. For stocks, volume is measured in the number of shares traded and, for futures and options, it is based on how many contracts have changed hands. Read more on Investopedia."
        case .sharesFloat:
            return "The term float refers to the regular shares a company has issued to the public that are available for investors to trade. Read more on Investopedia."
        case .shortRatio:
            return "The short ratio indicates the number of shares that investors sell short over the average daily volume of the stock on the basis of 1 or 3 months. Read more on Investopedia."
        case .beta:
            return "Beta is a measure of a stock's volatility in relation to the overall market. Read more on Investopedia."
        case .impliedVolatility:
            return "Then higher Implied volatility then higher changes to a price you should expect. Read more on Investopedia."
        case .revenueGrowthYoy:
            return "Quarterly revenue growth is an increase in a company's sales in one quarter compared to sales of a different quarter. Usually, then bigger Revenue Growth than a more attractive financial asset as it has a potential future upside. Read more on Investopedia."
        case .revenueGrowthFwd:
            return "Quarterly Revenue Growth, Year over Year for the future quarter based on earnings estimates. Read more on Investopedia."
        case .ebitdaGrowthYoy:
            return "Is used as an alternative to net income in some circumstances. Read more at Investopedia."
        case .epsGrowthYoy:
            return "Earnings per share (EPS) is calculated as a company's profit divided by the outstanding shares of its common stock. Read more on Investopedia."
        case .epsGrowthFwd:
            return "Earnings per share (EPS) is calculated as a company's profit divided by the outstanding shares of its common stock. Read more on Investopedia."
        case .address:
            return "Geographic location where the company headquarters is located"
        case .exchangeName:
            return "What the exchange company is traded in"
        case .marketCapitalization:
            return "Market capitalization, or \"market cap\" is the aggregate market value of a company represented in dollar amount. Read more on Investopedia."
        case .enterpriseValueToSales:
            return "In simple terms, it shows how much the company is valued compared to its sales (revenue) results. Usually, a lower EV/sales multiple will indicate that a company may be more attractive or undervalued in the market. Read more on Investopedia."
        case .priceToEarningsTtm:
            return "A metric that show the relative value of a company's shares in an apples-to-apples comparison. Usually the higher PE the most expensive stock. Read more on Investopedia. "
        case .priceToSalesTtm:
            return "It is an indicator of the value that financial markets have placed on each dollar of a company’s sales or revenues. It shows the relative value of a company's shares in an apples-to-apples comparison. Usually the higher P/S the most expensive stock. Read more on Investopedia."
        case .priceToBookValue:
            return "It's calculated by dividing the company's stock price per share by its book value per share (BVPS). Read more on Investopedia."
        case .enterpriseValueToEbitda:
            return "The enterprise multiple takes into account a company's debt and cash levels in addition to its stock price and relates that value to the firm's cash profitability. Read more on Investopedia."
        case .priceChange1m:
            return "This simple metric shows how a price changed in percentage over the past 30 days to give a perspective on how an asset moved."
        case .priceChange3m:
            return "This simple metric shows how a price changed in percentage over the past 90 days to give a perspective on how an asset moved. "
        case .priceChange1y:
            return "This simple metric shows how a price changed in percentage over the last year to give a perspective on how an asset moved. "
        case .dividendYield:
            return "The dividend yield—displayed as a percentage—is the amount of money a company pays shareholders for owning a share of its stock divided by its current stock price. Read more on Investopedia."
        case .dividendsPerShare:
            return "It is the number of dividends each shareholder of a company receives on a per-share basis. Read more on Investopedia. "
        case .dividendPayoutRatio:
            return "The ratio of the total amount of dividends paid out to shareholders relative to the net income of the company. Read more on Investopedia."
        case .yearsOfConsecutiveDividendGrowth:
            return "How many years company continues to increase dividend."
        case .dividendFrequency:
            return "Dividend frequency is how often a stock or fund pays a dividend. Read more on Investopedia. "
        case .epsActual:
            return "Primary Earnings Per Share (EPS) based on last earnings results. It's a measure of a company's earnings per common share, prior to the conversion of any outstanding convertible securities. Read more on Investopedia. "
        case .epsEstimate:
            return "Next quarter estimate for Primary Earnings Per Share (EPS) based on last earnings results. Earnings Per Share (EPS) based on last earnings results. It's a measure of a company's earnings per common share, prior to the conversion of any outstanding convertible securities. Read more on Investopedia."
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "How many times a company beat quarter earnings estimates during last year. Usually this metric counts during one year, so the company can beat or miss four times."
        case .epsSurprise:
            return "An earnings surprise occurs when a company's reported quarterly or annual profits are above or below analysts' expectations."
        case .revenueEstimateAvg0y:
            return "How much Revenue a company estimates to deliver during next earnings."
        case .revenueActual:
            return "How much Revenue a company delivered during last earnings. "
        case .revenueTtm:
            return "How much Revenue a company delivered during last earnings. "
        case .revenuePerShareTtm:
            return "Sales results per share is a ratio that computes the total revenue earned per share over a designated period. Read more on Investopedia."
        case .roi:
            return "ROI is expressed as a percentage and is calculated by dividing an investment's net profit (or loss) by its initial cost or outlay. Read more on Investopedia."
        case .netIncome:
            return "Net income includes all of the costs and expenses that a company incurred, which are subtracted from revenue. Read more on Investopedia. "
        case .assetCashAndEquivalents:
            return "Value of a company's assets that are cash or can be converted into cash immediately. Read more on Investopedia."
        case .roa:
            return "An indicator of how profitable a company is relative to its total assets. Read more on Investopedia."
        case .totalAssets:
            return "Everything that belongs to a company. Read more on Investopedia."
        case .ebitda:
            return "A measure of a company's overall financial performance and is used as an alternative to net income in some circumstances. Read more on Investopedia. "
        case .profitMargin:
            return "The net profit margin, or simply net margin, measures how much net income or profit is generated as a percentage of revenue. Read more on Investopedia."
        case .netDebt:
            return "Net debt shows much debt a company has on its balance sheet compared to its liquid assets. Read more on Investopedia."
        }
    }
    
    var explanationLinkString: String? {
        switch self {
        case .matchScore:
            return nil
        case .avgVolume10d:
            return "Read more on Investopedia"
        case .sharesOutstanding:
            return "Read more on Investopedia"
        case .shortPercentOutstanding:
            return "Read more on Investopedia"
        case .avgVolume90d:
            return "Read more on Investopedia"
        case .sharesFloat:
            return "Read more on Investopedia"
        case .shortRatio:
            return "Read more on Investopedia"
        case .beta:
            return "Read more on Investopedia"
        case .impliedVolatility:
            return "Read more on Investopedia"
        case .revenueGrowthYoy:
            return "Read more on Investopedia"
        case .revenueGrowthFwd:
            return "Read more on Investopedia"
        case .ebitdaGrowthYoy:
            return "Read more on Investopedia"
        case .epsGrowthYoy:
            return "Read more on Investopedia"
        case .epsGrowthFwd:
            return "Read more on Investopedia"
        case .address:
            return nil
        case .exchangeName:
            return nil
        case .marketCapitalization:
            return "Read more on Investopedia"
        case .enterpriseValueToSales:
            return "Read more on Investopedia"
        case .priceToEarningsTtm:
            return "Read more on Investopedia"
        case .priceToSalesTtm:
            return "Read more on Investopedia"
        case .priceToBookValue:
            return "Read more on Investopedia"
        case .enterpriseValueToEbitda:
            return "Read more on Investopedia"
        case .priceChange1m:
            return nil
        case .priceChange3m:
            return nil
        case .priceChange1y:
            return nil
        case .dividendYield:
            return "Read more on Investopedia"
        case .dividendsPerShare:
            return "Read more on Investopedia"
        case .dividendPayoutRatio:
            return "Read more on Investopedia"
        case .yearsOfConsecutiveDividendGrowth:
            return nil
        case .dividendFrequency:
            return "Read more on Investopedia"
        case .epsActual:
            return "Read more on Investopedia"
        case .epsEstimate:
            return "Read more on Investopedia"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return nil
        case .epsSurprise:
            return nil
        case .revenueEstimateAvg0y:
            return nil
        case .revenueActual:
            return nil
        case .revenueTtm:
            return nil
        case .revenuePerShareTtm:
            return "Read more on Investopedia"
        case .roi:
            return "Read more on Investopedia"
        case .netIncome:
            return "Read more on Investopedia"
        case .assetCashAndEquivalents:
            return "Read more on Investopedia"
        case .roa:
            return "Read more on Investopedia"
        case .totalAssets:
            return "Read more on Investopedia"
        case .ebitda:
            return "Read more on Investopedia"
        case .profitMargin:
            return "Read more on Investopedia"
        case .netDebt:
            return "Read more on Investopedia"
        }
    }
    
    var explanationLink: String? {
        switch self {
        case .matchScore:
            return nil
        case .avgVolume10d:
            return "https://www.investopedia.com/articles/technical/02/010702.asp"
        case .sharesOutstanding:
            return "https://www.investopedia.com/terms/o/outstandingshares.asp"
        case .shortPercentOutstanding:
            return "https://www.investopedia.com/articles/01/082201.asp"
        case .avgVolume90d:
            return "https://www.investopedia.com/articles/technical/02/010702.asp"
        case .sharesFloat:
            return "https://www.investopedia.com/ask/answers/what-is-companys-float/"
        case .shortRatio:
            return "https://www.investopedia.com/terms/s/shortinterestratio.asp"
        case .beta:
            return "https://www.investopedia.com/investing/beta-know-risk/"
        case .impliedVolatility:
            return "https://www.investopedia.com/terms/i/iv.asp"
        case .revenueGrowthYoy:
            return "https://www.investopedia.com/terms/q/quarterlyrevenuegrowth.asp"
        case .revenueGrowthFwd:
            return "https://www.investopedia.com/terms/f/fowardlookingearnings.asp"
        case .ebitdaGrowthYoy:
            return "https://www.investopedia.com/terms/e/ebitda.asp"
        case .epsGrowthYoy:
            return "https://www.investopedia.com/terms/e/eps.asp"
        case .epsGrowthFwd:
            return "https://www.investopedia.com/terms/e/eps.asp"
        case .address:
            return nil
        case .exchangeName:
            return nil
        case .marketCapitalization:
            return "https://www.investopedia.com/investing/market-capitalization-defined/"
        case .enterpriseValueToSales:
            return "https://www.investopedia.com/terms/e/enterprisevaluesales.asp"
        case .priceToEarningsTtm:
            return "https://www.investopedia.com/terms/p/price-earningsratio.asp"
        case .priceToSalesTtm:
            return "https://www.investopedia.com/terms/p/price-to-salesratio.asp"
        case .priceToBookValue:
            return "https://www.investopedia.com/terms/p/price-to-bookratio.asp"
        case .enterpriseValueToEbitda:
            return "https://www.investopedia.com/terms/e/ev-ebitda.asp"
        case .priceChange1m:
            return nil
        case .priceChange3m:
            return nil
        case .priceChange1y:
            return nil
        case .dividendYield:
            return "https://www.investopedia.com/terms/d/dividendyield.asp"
        case .dividendsPerShare:
            return "https://www.investopedia.com/ask/answers/032515/what-difference-between-earnings-share-and-dividends-share.asp"
        case .dividendPayoutRatio:
            return "https://www.investopedia.com/terms/d/dividendpayoutratio.asp"
        case .yearsOfConsecutiveDividendGrowth:
            return nil
        case .dividendFrequency:
            return "https://www.investopedia.com/terms/d/dividend_frequency.asp"
        case .epsActual:
            return "https://www.investopedia.com/terms/p/primary-eps.asp"
        case .epsEstimate:
            return "https://www.investopedia.com/terms/p/primary-eps.asp"
        case .beatenQuarterlyEpsEstimationCountTtm:
            return nil
        case .epsSurprise:
            return nil
        case .revenueEstimateAvg0y:
            return nil
        case .revenueActual:
            return nil
        case .revenueTtm:
            return nil
        case .revenuePerShareTtm:
            return "https://www.investopedia.com/terms/s/salespershare.asp"
        case .roi:
            return "https://www.investopedia.com/terms/r/returnoninvestment.asp"
        case .netIncome:
            return "https://www.investopedia.com/ask/answers/101314/what-are-differences-between-gross-profit-and-net-income.asp"
        case .assetCashAndEquivalents:
            return "https://www.investopedia.com/terms/c/cashandcashequivalents.asp"
        case .roa:
            return "https://www.investopedia.com/terms/r/returnonassets.asp"
        case .totalAssets:
            return "https://www.investopedia.com/terms/a/asset.asp"
        case .ebitda:
            return "https://www.investopedia.com/terms/e/ebitda.asp"
        case .profitMargin:
            return "https://www.investopedia.com/terms/n/net_margin.asp"
        case .netDebt:
            return "https://www.investopedia.com/terms/e/ebitda.asp"
        }
    }
    
    var explanationHeight: Float {
    
        let width = UIScreen.main.bounds.width
        let titleTopOffset = 20.0
        let titleEdgeOffset = 28.0
        let descriptionEdgeOffset = 24.0
        let descriptionTopOffset = 16.0
        let bottomOffset = 10.0
        
        let titleWidth = width - titleEdgeOffset * 2.0
        let descriptionWidth = width - descriptionEdgeOffset * 2.0
        
        let title = self.explanationTitle
        let description = self.explanationDescription
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.proDisplaySemibold(20.0)
        titleLabel.textColor = UIColor.init(hexString: "#1F2E35", alpha: 1.0)
        titleLabel.textAlignment = .left
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        let titleSize = titleLabel.sizeThatFits(CGSize(width: titleWidth,
                                                      height: CGFloat.greatestFiniteMagnitude))
        
        let descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.proDisplayRegular(14.0)
        descriptionTextView.contentInset = .zero
        descriptionTextView.textColor = UIColor(hexString: "#687379")
        descriptionTextView.textAlignment = .left
        descriptionTextView.text = description
        let descriptionSize = descriptionTextView.sizeThatFits(CGSize(width: descriptionWidth,
                                                               height: CGFloat.greatestFiniteMagnitude))
        
        let height = titleTopOffset + titleSize.height + descriptionTopOffset + descriptionSize.height + bottomOffset
        return Float(height)
    }
}
