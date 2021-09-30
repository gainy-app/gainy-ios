//
//  YourCollectionTipCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.09.2021.
//

import UIKit
import PureLayout

struct NoCollectionViewModel {    
    let id: String = "1"
}

extension NoCollectionViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: NoCollectionViewModel, rhs: NoCollectionViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

final class YourCollectionTipCell: SwipeCollectionViewCell {
    
}
