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
                                                dividendGrowthPercent: model.financialMetrics.dividendGrowthPercent.cleanOneDecimalP,
                                                growthRateYOY: model.financialMetrics.growthRateYOY.cleanOneDecimalP,
                                                evs: model.financialMetrics.evs.cleanOneDecimal,
                                                marketCap: model.financialMetrics.marketCapitalization.formatUsingAbbrevation(),
                                                monthToDay: (model.financialMetrics.monthToDay * 100.0).cleanOneDecimalP,
                                                netProfit: model.financialMetrics.netProfit.cleanOneDecimalP,
                                                highlight: model.financialMetrics.highlight,
                                                rawTicker: model.rawTicker!)        
    }
}
