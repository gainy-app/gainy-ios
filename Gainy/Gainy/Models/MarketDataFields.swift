//
//  MarketDataFields.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import Foundation

enum MarketDataField: Int, Codable, CaseIterable {
    case
    
    // MATCH SCORE
    matchScore = 0,
    
    // TRADING
    avgVolume10d, // avg_volume_10d
    sharesOutstanding, // shares_outstanding
    shortPercentOutstanding, // short_percent_outstanding
    avgVolume90d, // avg_volume_90d
    sharesFloat, // shares_float
    shortRatio, // short_ratio
    beta, // beta
    impliedVolatility, // implied_volatility,
    volatility52Weeks,
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
        var volatility52Weeks = "ERROR"
        if let min = ticker.tickerMetrics?.relativeHistoricalVolatilityAdjustedMin_1y?.cleanOneDecimal,
           let max = ticker.tickerMetrics?.relativeHistoricalVolatilityAdjustedMax_1y?.cleanOneDecimal {
            volatility52Weeks = min + "-" + max + "%"
        }
        switch self {
            
        case .avgVolume10d:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "10 DAYS", value: Float(ticker.tickerMetrics?.avgVolume_10d ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .sharesOutstanding:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.sharesOutstanding ?? 0).formatUsingAbbrevation(), marketDataField: self)
        case .shortPercentOutstanding:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: (Float(ticker.tickerMetrics?.shortPercentOutstanding ?? 0.0) * 100.0).cleanOneDecimalP, marketDataField: self)
        case .avgVolume90d:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "90 DAYS", value: Float(ticker.tickerMetrics?.avgVolume_90d ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .sharesFloat:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.sharesFloat ?? 0).formatUsingAbbrevation(), marketDataField: self)
        case .shortRatio:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.shortRatio ?? 0).formatUsingAbbrevation(), marketDataField: self)
        case .beta:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.beta ?? 0).formatUsingAbbrevation(), marketDataField: self)
        case .impliedVolatility:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.impliedVolatility ?? 0).cleanOneDecimalP, marketDataField: self)
        case .volatility52Weeks:
            marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: volatility52Weeks, marketDataField: self)
                                       
        
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
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.enterpriseValueToSales ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .priceToEarningsTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.priceToEarningsTtm ?? 0.0).cleanOneDecimal, marketDataField: self)
        case .priceToSalesTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.priceToSalesTtm ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .priceToBookValue:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.priceToBookValue ?? 0.0).cleanOneDecimal, marketDataField: self)
        case .enterpriseValueToEbitda:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "TTM", value: Float(ticker.tickerMetrics?.enterpriseValueToEbitda ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
            
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
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "", value: Float(ticker.tickerMetrics?.beatenQuarterlyEpsEstimationCountTtm ?? 0).cleanOneDecimal, marketDataField: self)
        case .epsSurprise:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "Beats or Misses by", value: Float(ticker.tickerMetrics?.epsSurprise ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenueEstimateAvg0y:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "annual", value: Float(ticker.tickerMetrics?.revenueEstimateAvg_0y ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenueActual:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "Beats or Misses by", value: Float(ticker.tickerMetrics?.revenueActual ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
            
        case .revenueTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.revenueTtm ?? 0.0).formatUsingAbbrevation(), marketDataField: self)
        case .revenuePerShareTtm:
             marketData = TickerInfo.MarketData.init(name: "\(self.title)", period: "ANNUAL, TTM", value:  (ticker.tickerMetrics?.revenuePerShareTtm ?? 0.0).cleanOneDecimal, marketDataField: self)
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
        case .volatility52Weeks:
            return "Volatility range 52 weeks"
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
            return "Prices / Sales, TTM"
        case .priceToBookValue:
            return "Price / Book "
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
            return "Match\nScore"
        case .avgVolume10d:
            return "Avg Vol\n10 days".uppercased()
        case .sharesOutstanding:
            return "Shares\nOutstanding".uppercased()
        case .shortPercentOutstanding:
            return "Short of\nOutstanding Stocks".uppercased()
        case .avgVolume90d:
            return "Avg Vol,\n90 days".uppercased()
        case .sharesFloat:
            return "Shares\nFloat".uppercased()
        case .shortRatio:
            return "Short\nRatio".uppercased()
        case .beta:
            return "beta".uppercased()
        case .impliedVolatility:
            return "Implied Volatility\nCurrent".uppercased()
        case .volatility52Weeks:
            return "Volatility range\n52 weeks".uppercased()
        case .revenueGrowthYoy:
            return "Revenue\nGrowth, TTM".uppercased()
        case .revenueGrowthFwd:
            return "Revenue\nGrowth, FWD".uppercased()
        case .ebitdaGrowthYoy:
            return "EBITDA\nGrowth, TTM".uppercased()
        case .epsGrowthYoy:
            return "EPS\nGrowth, TTM".uppercased()
        case .epsGrowthFwd:
            return "EPS\nGrowth, FWD".uppercased()
        case .address:
            return "Company HQ\nlocation".uppercased()
        case .exchangeName:
            return "Exchange\nname".uppercased()
        case .marketCapitalization:
            return "Market\nCap".uppercased()
        case .enterpriseValueToSales:
            return "EV/S,\nTTM"
        case .priceToEarningsTtm:
            return "PE,\nTTM"
        case .priceToSalesTtm:
            return "Prices/Sales,\nTTM".uppercased()
        case .priceToBookValue:
            return "Price / \nBook".uppercased()
        case .enterpriseValueToEbitda:
            return "EV / EBITDA,\nTTM".uppercased()
        case .priceChange1m:
            return "30d price\nchange".uppercased()
        case .priceChange3m:
            return "90d price\nchange".uppercased()
        case .priceChange1y:
            return "1y price\nchange".uppercased()
        case .dividendYield:
            return "Dividend\nyield".uppercased()
        case .dividendsPerShare:
            return "Dividends / \nShare".uppercased()
        case .dividendPayoutRatio:
            return "Dividend Payout\nRatio".uppercased()
        case .yearsOfConsecutiveDividendGrowth:
            return "Years of\ndividend growth".uppercased()
        case .dividendFrequency:
            return "Dividend\nFrequency".uppercased()
        case .epsActual:
            return "EPS\nActual".uppercased()
        case .epsEstimate:
            return "EPS\nEstimate".uppercased()
        case .beatenQuarterlyEpsEstimationCountTtm:
            return "Beaten\nexpectations".uppercased()
        case .epsSurprise:
            return "EPS\nSurprise".uppercased()
        case .revenueEstimateAvg0y:
            return "Next Revenue\nEstimate".uppercased()
        case .revenueActual:
            return "Revenue\nActual".uppercased()
        case .revenueTtm:
            return "Revenues".uppercased()
        case .revenuePerShareTtm:
            return "Revenue / \nShare".uppercased()
        case .roi:
            return "ROI"
        case .netIncome:
            return "Net\nincome".uppercased()
        case .assetCashAndEquivalents:
            return "Cash and\nEquivalents".uppercased()
        case .roa:
            return "ROA"
        case .totalAssets:
            return "Total\nAssets".uppercased()
        case .ebitda:
            return "EBITDA"
        case .profitMargin:
            return "Net\nProfit".uppercased()
        case .netDebt:
            return "Total\nDebt".uppercased()
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
            return "short_percent_outstanding"
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
        case .volatility52Weeks:
            return "relative_historical_volatility_adjusted_min_1y"
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
            return "eps_surprise"
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
            return "net_income"
        case .assetCashAndEquivalents:
            return "asset_cash_and_equivalents"
        case .roa:
            return "roa"
        case .totalAssets:
            return "total_assets"
        case .ebitda:
            return "ebitda"
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
        case .volatility52Weeks:
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
                return lhs.rawTicker.matchScore < rhs.rawTicker.matchScore
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
            case .volatility52Weeks:
                return (lhs.rawTicker.tickerMetrics?.absoluteHistoricalVolatilityAdjustedCurrent ?? 0.0) < (rhs.rawTicker.tickerMetrics?.absoluteHistoricalVolatilityAdjustedCurrent ?? 0.0)
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
                return (lhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0) < (rhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0)
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
                return lhs.rawTicker.matchScore > rhs.rawTicker.matchScore
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
            case .volatility52Weeks:
                return (lhs.rawTicker.tickerMetrics?.absoluteHistoricalVolatilityAdjustedCurrent ?? 0.0) > (rhs.rawTicker.tickerMetrics?.absoluteHistoricalVolatilityAdjustedCurrent ?? 0.0)
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
                return (lhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0) > (rhs.rawTicker.tickerMetrics?.dividendYield ?? 0.0)
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
        
    /// Order to place on sorting
    static let rawOrder: [MarketDataField] = [matchScore, revenueGrowthYoy, enterpriseValueToSales, marketCapitalization, priceChange1m, profitMargin]
    
    /// Default metrics for ticker details
    static let metricsOrder: [MarketDataField] = [matchScore, revenueGrowthYoy, enterpriseValueToSales, marketCapitalization, priceChange1m, profitMargin]
}
