struct Collection {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
    let discovered: Bool // TODO: rename to recommended and invert
}

enum CollectionDTOMapper {
    static func map(_ dto: CollectionsQuery.Data.Collection) -> Collection {
        Collection(id: Int(dto.id)!,
                   image: dto.image,
                   name: dto.name,
                   description: dto.description,
                   stocksAmount: Int(dto.stocksCount)!,
                   discovered: dto.favoriteCollections.first?.isDefault ?? false)
    }
}

extension Collection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(discovered)
    }

    static func == (lhs: Collection, rhs: Collection) -> Bool {
        lhs.id == rhs.id && lhs.discovered == rhs.discovered
    }
}

// TODO: TEST

enum RecommendedCellButtonState {
    case checked
    case unchecked
}

struct YourCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
}

struct RecommendedCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
    let buttonState: RecommendedCellButtonState
}

extension YourCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: YourCollectionViewCellModel, rhs: YourCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension RecommendedCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(buttonState)
    }

    static func == (lhs: RecommendedCollectionViewCellModel, rhs: RecommendedCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id && lhs.buttonState == rhs.buttonState
    }
}

enum CollectionViewModelMapper {
    static func map(_ model: Collection) -> YourCollectionViewCellModel {
        YourCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount
        )
    }

    static func map(_ model: Collection) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount,
            buttonState: model.discovered ? .checked : .unchecked
        )
    }
}
