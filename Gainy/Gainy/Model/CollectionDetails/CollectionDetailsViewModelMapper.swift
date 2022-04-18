enum CollectionDetailsViewModelMapper {
    static func map(_ model: CollectionDetails) -> CollectionDetailViewCellModel {
        CollectionDetailViewCellModel(
            id: model.id,
            image: model.collectionBackgroundImage,
            imageUrl: model.collectionBackgroundImageUrl,
            name: model.collectionName,
            description: model.collectionDescription,
            stocksAmount: model.collectionStocksAmount,
            dailyGrow: model.collectionDailyGrow,
            inYourCollectionList: model.isInYourCollectionsList,
            cards: model.cards.map { CollectionDetailsViewModelMapper.map($0) }
        )
    }

    static func map(_ model: TickerDetails) -> CollectionCardViewCellModel {
        let marketCapValue = model.tickerMetrics.marketCapitalization
        var marketCapitalizationString = ""
        if marketCapValue >= 1_000_000_000_000 {
            marketCapitalizationString = "$\(marketCapValue / 1_000_000_000_000)T"
        } else if marketCapValue >= 1_000_000_000 {
            marketCapitalizationString = "$\(marketCapValue / 1_000_000_000)B"
        } else if marketCapValue >= 1_000_000 {
            marketCapitalizationString = "$\(marketCapValue / 1_000_000)M"
        } else if marketCapValue >= 1_000 {
            marketCapitalizationString = "$\(marketCapValue / 1_000)K"
        } else {
            marketCapitalizationString = "$\(marketCapValue)"
        }

        let priceIncreased = model.financialMetrics.todaysPriceChange > 0
        let tickerPercentChangeText = priceIncreased
            ? " +\(model.financialMetrics.todaysPriceChange.cleanTwoDecimal)%"
            : " \(model.financialMetrics.todaysPriceChange.cleanTwoDecimal)%"
        
        let sharesOutstanding = Float(model.tickerMetrics.sharesOutstanding).formatUsingAbbrevation(false)
        let shortPercentOutstanding = (Float(model.tickerMetrics.shortPercentOutstanding) * 100.0).cleanOneDecimalP
    
        let value = model.tickerMetrics.beatenQuarterlyEpsEstimationCountTtm
        let beatenQuarterlyEpsEstimationCountTtm = "{" + Float(value).cleanOneDecimal + "} / 4"
        
        return CollectionCardViewCellModel.init(
            tickerCompanyName: model.companyName,
            tickerSymbol: model.tickerSymbol,
            sharesOutstanding: sharesOutstanding,
            shortPercentOutstanding: shortPercentOutstanding,
            avgVolume10d: model.tickerMetrics.avgVolume10d.formatUsingAbbrevation(),
            avgVolume90d: model.tickerMetrics.avgVolume90d.formatUsingAbbrevation(),
            sharesFloat: model.tickerMetrics.sharesFloat.formatUsingAbbrevation(),
            shortRatio: model.tickerMetrics.shortRatio.formatUsingAbbrevation(false),
            beta: model.tickerMetrics.beta.formatUsingAbbrevation(false),
            impliedVolatility: model.tickerMetrics.impliedVolatility.zeroDecimalP,
            volatility52Weeks: model.tickerMetrics.volatility52Weeks,
            revenueGrowthYoy: (model.tickerMetrics.revenueGrowthYoy * 100.0).cleanOneDecimalP,
            revenueGrowthFwd: (model.tickerMetrics.revenueGrowthFwd * 100.0).cleanOneDecimalP,
            ebitdaGrowthYoy: (model.tickerMetrics.ebitdaGrowthYoy * 100.0).cleanOneDecimalP,
            epsGrowthYoy: (model.tickerMetrics.epsGrowthYoy * 100.0).cleanOneDecimalP,
            epsGrowthFwd: (model.tickerMetrics.epsGrowthFwd * 100.0).cleanOneDecimalP,
            address: model.tickerMetrics.address,
            exchangeName: model.tickerMetrics.exchangeName,
            marketCapitalization: model.tickerMetrics.marketCapitalization.formatUsingAbbrevation(),
            enterpriseValueToSales: model.tickerMetrics.enterpriseValueToSales.formatUsingAbbrevation(false),
            priceToEarningsTtm: model.tickerMetrics.priceToEarningsTtm.cleanOneDecimal,
            priceToSalesTtm: model.tickerMetrics.priceToSalesTtm.formatUsingAbbrevation(false),
            priceToBookValue: model.tickerMetrics.priceToBookValue.cleanOneDecimal,
            enterpriseValueToEbitda: model.tickerMetrics.enterpriseValueToEbitda.formatUsingAbbrevation(false),
            priceChange1m: (model.tickerMetrics.priceChange1m * 100.0).cleanOneDecimalP,
            priceChange3m: (model.tickerMetrics.priceChange3m * 100.0).cleanOneDecimalP,
            priceChange1y: (model.tickerMetrics.priceChange1y * 100.0).cleanOneDecimalP,
            dividendYield: (model.tickerMetrics.dividendYield * 100.0).cleanOneDecimalP,
            dividendsPerShare: model.tickerMetrics.dividendsPerShare.cleanOneDecimal,
            dividendPayoutRatio: (model.tickerMetrics.dividendPayoutRatio * 100.0).cleanOneDecimalP,
            yearsOfConsecutiveDividendGrowth: model.tickerMetrics.yearsOfConsecutiveDividendGrowth.cleanOneDecimal,
            dividendFrequency: model.tickerMetrics.dividendFrequency,
            epsActual: model.tickerMetrics.epsActual.formatUsingAbbrevation(),
            epsEstimate: model.tickerMetrics.epsEstimate.formatUsingAbbrevation(),
            beatenQuarterlyEpsEstimationCountTtm: beatenQuarterlyEpsEstimationCountTtm,
            epsSurprise: model.tickerMetrics.epsSurprise.cleanTwoDecimalP,
            revenueEstimateAvg0y: model.tickerMetrics.revenueEstimateAvg0y.formatUsingAbbrevation(),
            revenueActual: model.tickerMetrics.revenueActual.formatUsingAbbrevation(),
            revenueTtm: model.tickerMetrics.revenueTtm.formatUsingAbbrevation(),
            revenuePerShareTtm: model.tickerMetrics.revenuePerShareTtm.cleanOneDecimal,
            roi: model.tickerMetrics.roi.percent,
            netIncome: model.tickerMetrics.netIncome.formatUsingAbbrevation(),
            assetCashAndEquivalents: model.tickerMetrics.assetCashAndEquivalents.formatUsingAbbrevation(),
            roa: model.tickerMetrics.roa.percent,
            totalAssets: model.tickerMetrics.totalAssets.formatUsingAbbrevation(),
            ebitda: model.tickerMetrics.ebitda.formatUsingAbbrevation(),
            profitMargin: model.tickerMetrics.profitMargin.percent,
            netDebt: model.tickerMetrics.netDebt.formatUsingAbbrevation(),
            highlight: model.tickerMetrics.highlight,
            rawTicker: model.rawTicker)
    }
}
