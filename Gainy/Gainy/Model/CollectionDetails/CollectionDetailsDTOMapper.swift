import SkeletonView
import GainyAPI

enum CollectionDetailsDTOMapper {
    static func mapAsCollectionFromRecommendedCollections(
        _ dto: RemoteCollectionDetails
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id ?? -1,
            uniqId: dto.uniqId,
            collectionBackgroundImage: dto.name?.lowercased() ?? "", collectionBackgroundImageUrl: dto.imageUrl ?? "",
            collectionName: dto.name ?? "",
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.size ?? 0,
            collectionDailyGrow: dto.metrics?.relativeDailyChange ?? 0.0,
            matchScore: dto.matchScore ?? RemoteCollectionDetails.MatchScore(),
            isInYourCollectionsList: false,
            prevDateData: PrevDayData(ttfMetrics: dto.metrics),
            cards: dto.prefetchedTickers
        )
    }
    
    static func mapAsCollectionFromYourCollections(
        _ dto: RemoteCollectionDetails
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id ?? -1,
            uniqId: dto.uniqId,
            collectionBackgroundImage: dto.name?.lowercased() ?? "", collectionBackgroundImageUrl: dto.imageUrl ?? "",
            collectionName: dto.name ?? "",
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.size ?? 0,
            collectionDailyGrow: dto.metrics?.relativeDailyChange ?? 0.0,
            matchScore: dto.matchScore ?? RemoteCollectionDetails.MatchScore(),
            isInYourCollectionsList: true,
            prevDateData: PrevDayData(ttfMetrics: dto.metrics),
            cards: dto.prefetchedTickers
        )
    }
    
    static func mapTickerDetails(
        _ dto: RemoteTickerDetails
    ) -> TickerDetails {
        let tickerFinancials = dto.realtimeMetrics
        let tickerMetrics = dto.tickerMetrics
        let highlight = dto.tickerHighlights.first
        if tickerMetrics == nil {
            GainyAnalytics.logEvent("Missing TickerMetricsData", params: ["symbol": dto.symbol, "name" : dto.name ?? ""])
        }
        return TickerDetails(
            tickerSymbol: dto.symbol ?? "",
            companyName: (dto.name ?? "").companyMarkRemoved,
            description: dto.description ?? "",
            financialMetrics: tickerFinancials != nil ? CollectionDetailsDTOMapper.mapFinancialMetrics(
                tickerFinancials!
            ) : TickerFinancialMetrics.init(todaysPriceChange: 0.0, currentPrice: 0.0),
            tickerMetrics: tickerMetrics != nil ? CollectionDetailsDTOMapper.mapTickerMetrics(
                tickerMetrics!, highlight?.highlight ?? ""
            ) : TickerMetricsData(
                matchScore: 0.0,
                sharesOutstanding: 0.0,
                shortPercentOutstanding: 0.0,
                avgVolume10d: 0.0,
                avgVolume90d: 0.0,
                sharesFloat: 0.0,
                shortRatio: 0.0,
                beta: 0.0,
                impliedVolatility: 0.0,
                volatility52Weeks: "null",
                revenueGrowthYoy: 0.0,
                revenueGrowthFwd: 0.0,
                ebitdaGrowthYoy: 0.0,
                epsGrowthYoy: 0.0,
                epsGrowthFwd: 0.0,
                address: "None",
                exchangeName: "null",
                marketCapitalization: 0.0,
                enterpriseValueToSales: 0.0,
                priceToEarningsTtm: 0.0,
                priceToSalesTtm: 0.0,
                priceToBookValue: 0.0,
                enterpriseValueToEbitda: 0.0,
                priceChange1m: 0.0,
                priceChange3m: 0.0,
                priceChange1y: 0.0,
                dividendYield: 0.0,
                dividendsPerShare: 0.0,
                dividendPayoutRatio: 0.0,
                yearsOfConsecutiveDividendGrowth: 0.0,
                dividendFrequency: "None",
                epsActual: 0.0,
                epsEstimate: 0.0,
                beatenQuarterlyEpsEstimationCountTtm: 0.0,
                epsSurprise: 0.0,
                revenueEstimateAvg0y: 0.0,
                revenueActual: 0.0,
                revenueTtm: 0.0,
                revenuePerShareTtm: 0.0,
                roi: 0.0,
                netIncome: 0.0,
                assetCashAndEquivalents: 0.0,
                roa: 0.0,
                totalAssets: 0.0,
                ebitda: 0.0,
                profitMargin: 0.0,
                netDebt: 0.0,
                highlight: ""),
            rawTicker: dto
        )
    }
    
    static func mapTickerMetrics(
        _ dto: RemoteTickerDetails.TickerMetric, _ highlight: String
    ) -> TickerMetricsData {
        let marketCapitalization = dto.marketCapitalization != nil ? Float(dto.marketCapitalization!) : 0.0
        
        var volatility52Weeks = "null"
        let min = dto.relativeHistoricalVolatilityAdjustedMin_1y ?? float8(0.0)
        let max = dto.relativeHistoricalVolatilityAdjustedMin_1y ?? float8(0.0)
        if dto.relativeHistoricalVolatilityAdjustedMin_1y != nil,
           dto.relativeHistoricalVolatilityAdjustedMin_1y != nil {
            volatility52Weeks = (min * 100.0).zeroDecimal + "-" + (max * 100.0).zeroDecimal + "%"
        }
        
        return TickerMetricsData(
            matchScore: 0.0,
            sharesOutstanding: dto.sharesOutstanding != nil ? Float(dto.sharesOutstanding!) : 0.0,
            shortPercentOutstanding: dto.shortPercentOutstanding ?? 0.0,
            avgVolume10d: dto.avgVolume_10d ?? 0.0,
            avgVolume90d: dto.avgVolume_90d ?? 0.0,
            sharesFloat: dto.sharesFloat != nil ? Float(dto.sharesFloat!) : 0.0,
            shortRatio: dto.shortRatio ?? 0.0,
            beta: dto.beta ?? 0.0,
            impliedVolatility: dto.impliedVolatility ?? 0.0,
            volatility52Weeks: volatility52Weeks,
            revenueGrowthYoy: dto.revenueGrowthYoy ?? 0.0,
            revenueGrowthFwd: dto.revenueGrowthFwd ?? 0.0,
            ebitdaGrowthYoy: dto.ebitdaGrowthYoy ?? 0.0,
            epsGrowthYoy: dto.epsGrowthYoy ?? 0.0,
            epsGrowthFwd: dto.epsGrowthFwd ?? 0.0,
            address: dto.addressCity ?? "None",
            exchangeName: dto.exchangeName ?? "null",
            marketCapitalization: marketCapitalization,
            enterpriseValueToSales: dto.enterpriseValueToSales ?? 0.0,
            priceToEarningsTtm: dto.priceToEarningsTtm ?? 0.0,
            priceToSalesTtm: dto.priceToSalesTtm ?? 0.0,
            priceToBookValue: dto.priceToBookValue ?? 0.0,
            enterpriseValueToEbitda: dto.enterpriseValueToEbitda ?? 0.0,
            priceChange1m: dto.priceChange_1m ?? 0.0,
            priceChange3m: dto.priceChange_3m ?? 0.0,
            priceChange1y: dto.priceChange_1y ?? 0.0,
            dividendYield: dto.dividendYield ?? 0.0,
            dividendsPerShare: dto.dividendsPerShare ?? 0.0,
            dividendPayoutRatio: dto.dividendPayoutRatio ?? 0.0,
            yearsOfConsecutiveDividendGrowth: Float(dto.yearsOfConsecutiveDividendGrowth ?? 0),
            dividendFrequency: dto.dividendFrequency ?? "None",
            epsActual: dto.epsActual ?? 0.0,
            epsEstimate: dto.epsEstimate ?? 0.0,
            beatenQuarterlyEpsEstimationCountTtm: Float(dto.beatenQuarterlyEpsEstimationCountTtm ?? 0),
            epsSurprise: dto.epsSurprise ??  0.0,
            revenueEstimateAvg0y: dto.revenueEstimateAvg_0y ?? 0.0,
            revenueActual: dto.revenueActual ?? 0.0,
            revenueTtm: dto.revenueTtm ?? 0.0,
            revenuePerShareTtm: dto.revenuePerShareTtm ?? 0.0,
            roi: dto.roi ?? 0.0,
            netIncome: dto.netIncome ?? 0.0,
            assetCashAndEquivalents: dto.assetCashAndEquivalents ?? 0.0,
            roa: dto.roa ?? 0.0,
            totalAssets: dto.totalAssets ?? 0.0,
            ebitda: dto.ebitda ?? 0.0,
            profitMargin: dto.profitMargin ?? 0.0,
            netDebt: dto.netDebt ?? 0.0,
            highlight: highlight)
    }
    
    static func mapFinancialMetrics(
        _ dto: RemoteTickerDetails.RealtimeMetric
    ) -> TickerFinancialMetrics {
        TickerFinancialMetrics(
            todaysPriceChange: Float(dto.relativeDailyChange ?? 0.0) * 100.0,
            currentPrice: dto.actualPrice ?? 0.0
        )
    }
    
    //MARK:- Loaders
    
    static func loaderModels() -> [CollectionDetailViewCellModel] {
        var collections: [CollectionDetailViewCellModel] = []
        for hCell in 0...2 {
            var cards: [CollectionCardViewCellModel] = []
            for _ in 0...6 {
                cards.append(CollectionCardViewCellModel (
                        tickerCompanyName: Constants.CollectionDetails.demoNamePrefix + randomString(10),
                        tickerSymbol: randomString(4),
                        sharesOutstanding: "",
                        shortPercentOutstanding: "",
                        avgVolume10d: "",
                        avgVolume90d: "",
                        sharesFloat: "",
                        shortRatio: "",
                        beta: "",
                        impliedVolatility: "",
                        volatility52Weeks: "",
                        revenueGrowthYoy: "",
                        revenueGrowthFwd: "",
                        ebitdaGrowthYoy: "",
                        epsGrowthYoy: "",
                        epsGrowthFwd: "",
                        address: "",
                        exchangeName: "",
                        marketCapitalization: "",
                        enterpriseValueToSales: "",
                        priceToEarningsTtm: "",
                        priceToSalesTtm: "",
                        priceToBookValue: "",
                        enterpriseValueToEbitda: "",
                        priceChange1m: "",
                        priceChange3m: "",
                        priceChange1y: "",
                        dividendYield: "",
                        dividendsPerShare: "",
                        dividendPayoutRatio: "",
                        yearsOfConsecutiveDividendGrowth: "",
                        dividendFrequency: "",
                        epsActual: "",
                        epsEstimate: "",
                        beatenQuarterlyEpsEstimationCountTtm: "",
                        epsSurprise: "",
                        revenueEstimateAvg0y: "",
                        revenueActual: "",
                        revenueTtm: "",
                        revenuePerShareTtm: "",
                        roi: "",
                        netIncome: "",
                        assetCashAndEquivalents: "",
                        roa: "",
                        totalAssets: "",
                        ebitda: "",
                        profitMargin: "",
                        netDebt: "",
                        highlight: "",
                        rawTicker: RemoteTickerDetails.init(symbol: randomString(4),
                                                            name: Constants.CollectionDetails.demoNamePrefix + randomString(10),
                                                            description: randomString(20),
                                                            tickerHighlights: [])))
            }
            collections.append(CollectionDetailViewCellModel.init(id: Constants.CollectionDetails.loadingCellIDs[hCell], uniqID: "", image: "", imageUrl: "", name: "Loader 1", description: "Loader 1", stocksAmount: 1, dailyGrow: 0.0, matchScore: RemoteCollectionDetails.MatchScore(), inYourCollectionList: false, prevDateData: PrevDayData(), cards: cards))
        }
        return collections
    }
    
    private static func randomString(_ length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
