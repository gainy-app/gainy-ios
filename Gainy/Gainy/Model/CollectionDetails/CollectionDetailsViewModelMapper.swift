// TODO: 1: move to separate file
extension Float {
    var cleanOneDecimal: String {
       return self.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", self)
        : String(format: "%.1f", self)
    }

    var cleanTwoDecimal: String {
       return self.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", self)
        : String(format: "%.2f", self)
    }
}

enum CollectionDetailsViewModelMapper {
    static func map(_ model: CollectionDetails) -> CollectionDetailViewCellModel {
        CollectionDetailViewCellModel(
            id: model.id,
            image: model.collectionBackgroundImage,
            name: model.collectionName,
            description: model.collectionDescription,
            stocksAmount: "\(model.collectionStocksAmount)",
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
            ? "+\(model.financialMetrics.todaysPriceChange.cleanTwoDecimal)%"
            : "\(model.financialMetrics.todaysPriceChange.cleanTwoDecimal)%"

        return CollectionCardViewCellModel(
            tickerCompanyName: model.companyName,
            tickerSymbol: model.tickerSymbol,
            priceChange: tickerPercentChangeText,
            tickerPrice: "\(model.financialMetrics.currentPrice.cleanTwoDecimal)",
            dividendGrowthPercent: "\(model.financialMetrics.dividendGrowthPercent)",
            priceToEarnings: "\(model.financialMetrics.priceToEarnings.cleanOneDecimal)",
            marketCapitalization: marketCapitalizationString,
            highlight: model.financialMetrics.highlight
        )
    }
}
