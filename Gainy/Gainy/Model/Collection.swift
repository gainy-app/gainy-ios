struct Collection {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
    let discovered: Bool
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
