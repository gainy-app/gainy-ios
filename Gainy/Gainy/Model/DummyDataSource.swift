// TODO: remove when testing is completed
enum DummyDataSource {
    // MARK: Internal

    static var collections = [
        Collection(
            id: 0,
            discovered: true,
            name: "AI companies",
            description: "Technology companies that utilize artificial intelligence",
            stocksAmount: 15
        ),
        Collection(
            id: 2,
            discovered: true,
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17
        ),
        Collection(
            id: 3,
            discovered: true,
            name: "Global Dividend",
            description: "Global top rated dividended companies",
            stocksAmount: 119
        ),
        Collection(
            id: 4,
            discovered: true,
            name: "Recent IPOs",
            description: "Global IPOs that happen over last 6 months",
            stocksAmount: 33
        ),
    ]

    static var recommendedCollections = baseData + (400...900)
        .map { hashId in
            Collection(
                id: hashId,
                discovered: false,
                name: "AI companies",
                description: "Technology companies that utilize artificial intelligence",
                stocksAmount: 15
            )
        }

    // MARK: Private

    private static var baseData = [
        Collection(
            id: 10,
            discovered: false,
            name: "USA Fintech",
            description: "Fintech companies of USA",
            stocksAmount: 9
        ),
        Collection(
            id: 12,
            discovered: false,
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17
        ),
        Collection(
            id: 13,
            discovered: false,
            name: "Small cap ETFs",
            description: "ETFs of the stocks with market cap of $300M to $2B",
            stocksAmount: 11
        ),
        Collection(
            id: 14,
            discovered: false,
            name: "Global Cannabis",
            description: "Global cannabis companies stocks",
            stocksAmount: 33
        ),
        Collection(
            id: 15,
            discovered: false,
            name: "Mid cap stocks",
            description: "Companies with evaluation from $2B to $10B",
            stocksAmount: 107
        ),
    ]
}
