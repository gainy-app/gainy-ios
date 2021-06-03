// TODO: remove when testing is completed
enum DummyDataSource {
    static var collectionsRemote: [CollectionsQuery.Data.Collection] = []

    static var yourCollections = [
        Collection(
            id: 0,
            image: "collections-ai",
            name: "AI companies",
            description: "Technology companies that utilize artificial intelligence",
            stocksAmount: 15,
            isInYourCollections: true
        ),
        Collection(
            id: 2,
            image: "collections-global-evs",
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17,
            isInYourCollections: true
        ),
        Collection(
            id: 3,
            image: "collections-global-dividend",
            name: "Global Dividend",
            description: "Global top rated dividended companies",
            stocksAmount: 119,
            isInYourCollections: true
        ),
        Collection(
            id: 4,
            image: "collections-recent-ipos",
            name: "Recent IPOs",
            description: "Global IPOs that happen over last 6 months",
            stocksAmount: 33,
            isInYourCollections: true
        ),
        Collection(
            id: 5,
            image: "non-existing-image",
            name: "Speculative",
            description: "Speculative assets",
            stocksAmount: 19,
            isInYourCollections: true
        ),
    ]

    static var recommendedCollections = [
        Collection(
            id: 10,
            image: "collections-usa-fintech",
            name: "USA Fintech",
            description: "Fintech companies of USA",
            stocksAmount: 9,
            isInYourCollections: false
        ),
        Collection(
            id: 12,
            image: "collections-global-evs",
            name: "Global EVs",
            description: "Global electric vehicles companies",
            stocksAmount: 17,
            isInYourCollections: false
        ),
        Collection(
            id: 13,
            image: "non-exisiting-image",
            name: "AI companies",
            description: "Technology companies that utilize artificial intelligence",
            stocksAmount: 15,
            isInYourCollections: false
        ),
        Collection(
            id: 14,
            image: "collections-small-caps-etf",
            name: "Small cap ETFs",
            description: "ETFs of the stocks with market cap of $300M to $2B",
            stocksAmount: 11,
            isInYourCollections: false
        ),
        Collection(
            id: 15,
            image: "collections-global-cannabis",
            name: "Global Cannabis",
            description: "Global cannabis companies stocks",
            stocksAmount: 33,
            isInYourCollections: false
        ),
        Collection(
            id: 16,
            image: "collections-mid-cap-stocks",
            name: "Mid cap stocks",
            description: "Companies with evaluation from $2B to $10B",
            stocksAmount: 107,
            isInYourCollections: false
        ),
    ]
}
