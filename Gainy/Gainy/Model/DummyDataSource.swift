// TODO: remove when testing is completed
enum DummyDataSource {
    // MARK: Internal

    static var collectionsRemote: [CollectionsQuery.Data.Collection] = []

    static var collections = [
        Collection(
            id: 0,
            image: "",
            name: "AI companies",
            description: "Technology companies that utilize artificial intelligence",
            stocksAmount: 15,
            discovered: true
        ),
        Collection(
            id: 2,
            image: "",
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17,
            discovered: false
        ),
        Collection(
            id: 3,
            image: "",
            name: "Global Dividend",
            description: "Global top rated dividended companies",
            stocksAmount: 119,
            discovered: false
        ),
        Collection(
            id: 4,
            image: "",
            name: "Recent IPOs",
            description: "Global IPOs that happen over last 6 months",
            stocksAmount: 33,
            discovered: false
        ),
    ]

    static var recommendedCollections = baseData + (400...410)
        .map { hashId in
            Collection(
                id: hashId,
                image: "",
                name: "AI companies",
                description: "Technology companies that utilize artificial intelligence",
                stocksAmount: 15,
                discovered: false
            )
        }

    // MARK: Private

    private static var baseData = [
        Collection(
            id: 10,
            image: "",
            name: "USA Fintech",
            description: "Fintech companies of USA",
            stocksAmount: 9,
            discovered: false
        ),
        Collection(
            id: 12,
            image: "",
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17,
            discovered: false
        ),
        Collection(
            id: 13,
            image: "",
            name: "Small cap ETFs",
            description: "ETFs of the stocks with market cap of $300M to $2B",
            stocksAmount: 11,
            discovered: false
        ),
        Collection(
            id: 14,
            image: "",
            name: "Global Cannabis",
            description: "Global cannabis companies stocks",
            stocksAmount: 33,
            discovered: false
        ),
        Collection(
            id: 15,
            image: "",
            name: "Mid cap stocks",
            description: "Companies with evaluation from $2B to $10B",
            stocksAmount: 107,
            discovered: false
        ),
    ]
}
