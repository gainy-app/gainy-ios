struct CollectionDetailViewCellModel {
    let id: Int
    let uniqID: String
    let image: String
    let imageUrl: String
    let name: String
    let description: String
    let stocksAmount: Int
    let dailyGrow: Float
    let matchScore: RemoteCollectionDetails.MatchScore
    let inYourCollectionList: Bool
    let lastDayPrice: Float
    var cards: [CollectionCardViewCellModel]
    
    var combinedTags: [TickerTag] = []
    
    var chartRange: ScatterChartView.ChartPeriod = .d1
    var isDataLoaded: Bool = false
    
    //Charts
    let topChart: TTFChartViewModel = TTFChartViewModel.init(spGrow: 0.0, chartData: .init(points: [0.0]), sypChartData: .init(points: [15, 20, 25, 10]), isSPPVisible: false)
    
    mutating func addCards(_ newCards: [CollectionCardViewCellModel]) {
        cards.append(contentsOf: newCards)
    }
    
    mutating func addTags(_ tags: [TickerTag]) {
        combinedTags.append(contentsOf: tags)
    }
    
    //Gains
    
    var statsDayName: String {
        switch chartRange {
        case .d1:
            return "Today Gain"
        case .w1:
            return "Week Gain"
        case .m1:
            return "Month Gain"
        case .m3:
            return "3M Gain"
        case .y1:
            return "Year Gain"
        case .y5:
            return "5Y Gain"
        case .all:
            return "Total Gain"            
        }
    }
    
    var statsDayValue: String {
        switch chartRange {
        case .d1:
            return dailyGrow.percentUnsigned
        default:
            return topChart.chartData.startEndDiff.percentRawUnsigned
        }
    }
    
    var statsDayRaw: Float {
        switch chartRange {
        case .d1:
            return dailyGrow
        default:
            return Float(topChart.chartData.startEndDiff)
        }
    }
}

extension CollectionDetailViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(stocksAmount)
    }

    static func == (lhs: CollectionDetailViewCellModel, rhs: CollectionDetailViewCellModel) -> Bool {
        lhs.id == rhs.id && lhs.inYourCollectionList == rhs.inYourCollectionList
    }
}

extension CollectionDetailViewCellModel : CustomStringConvertible {
}
