struct Collection {
    let id: Int
    let name: String
    let description: String
    let stocksAmount: Int
}

struct CollectionDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let stocksAmount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stocksAmount
    }
}

enum CollectionDTOMapper {
  static func map(_ dto: CollectionDTO) -> Collection {
    Collection(id: dto.id,
               name: dto.name,
               description: dto.description,
               stocksAmount: dto.stocksAmount)
  }
}

extension Collection: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: Collection, rhs: Collection) -> Bool {
      lhs.id == rhs.id
    }
}
