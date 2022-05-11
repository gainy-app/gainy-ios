//
//  HomeTickersCollectionViewCellModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.05.2022.
//

import UIKit

struct HomeTickersCollectionViewCellModel {
    let gainers: [RemoteTicker]
    let isGainers: Bool
}

extension HomeTickersCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isGainers)
    }

    static func == (lhs: HomeTickersCollectionViewCellModel, rhs: HomeTickersCollectionViewCellModel) -> Bool {
        lhs.isGainers == rhs.isGainers
    }
}
