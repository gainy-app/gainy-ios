struct Collection {
    let id: Int
    let discovered: Bool
    let name: String
    let description: String
    let stocksAmount: Int
}

struct CollectionDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stocksAmount
    }

    let id: Int
    let name: String
    let description: String
    let stocksAmount: Int
}

enum CollectionDTOMapper {
    static func map(_ dto: CollectionDTO) -> Collection {
        Collection(id: dto.id,
                   discovered: false,
                   name: dto.name,
                   description: dto.description,
                   stocksAmount: dto.stocksAmount)
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
