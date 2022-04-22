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
