struct CollectionHeaderViewModel {
    let title: String
    let description: String
}

extension CollectionHeaderViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    static func == (lhs: CollectionHeaderViewModel, rhs: CollectionHeaderViewModel) -> Bool {
        lhs.title == rhs.title
    }
}
