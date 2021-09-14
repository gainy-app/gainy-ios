enum CollectionDetailsViewModelMapper {
    static func map(_ model: CollectionDetails) -> CollectionDetailViewCellModel {
        CollectionDetailViewCellModel(
            id: model.id,
            image: model.collectionBackgroundImage, imageUrl: model.collectionBackgroundImageUrl,
            name: model.collectionName,
            description: model.collectionDescription,
            stocksAmount: "\(model.collectionStocksAmount)",
            inYourCollectionList: model.isInYourCollectionsList,
            cards: model.cards.map { CollectionDetailsViewModelMapper.map($0) }
        )
    }

    static func map(_ model: TickerDetails) -> CollectionCardViewCellModel {
        let marketCapValue = model.financialMetrics.marketCapitalization
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

        
        return CollectionCardViewCellModel.init(tickerCompanyName: model.companyName,
                                                tickerSymbol: model.tickerSymbol,
                                                priceChange: tickerPercentChangeText,
                                                tickerPrice: "\(model.financialMetrics.currentPrice.cleanTwoDecimal)",
                                                dividendGrowthPercent: "\(model.financialMetrics.dividendGrowthPercent)",
                                                growthRateYOY: model.financialMetrics.growthRateYOY.cleanTwoDecimal,
                                                evs: model.financialMetrics.evs.cleanOneDecimal,
                                                marketCap: model.financialMetrics.marketCapitalization.formatUsingAbbrevation(),
                                                monthToDay: "\(model.financialMetrics.monthToDay.cleanTwoDecimal)",
                                                netProfit: model.financialMetrics.netProfit.percent,
                                                highlight: model.financialMetrics.highlight,
                                                rawTicker: model.rawTicker!)        
    }
}
