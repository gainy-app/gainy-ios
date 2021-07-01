extension Array {
    mutating func move(from fromIndex: Index, to toIndex: Index) {
        guard fromIndex != toIndex else { return }

        if abs(toIndex - fromIndex) == 1 {
            return swapAt(fromIndex, toIndex)
        }

        let elementToMove = remove(at: fromIndex)
        insert(elementToMove, at: toIndex)
    }
}
