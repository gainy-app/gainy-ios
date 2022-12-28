//
//  PositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 15.11.22.
//

import UIKit
import GainyCommon

final class PositionCell: UICollectionViewCell {
    
    private var positionView: PositionView = PositionView().loadViewt() as! PositionView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(positionView)
        NSLayoutConstraint.activate([
            positionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            positionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            positionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            positionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with model: CollectionDetailPurchaseInfoModel) {
        positionView.configure(with: model)
    }
}

extension UIView {
    func loadViewt() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func loadView(index: Array.Index) -> UIView? {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)
        let view = nib.instantiate(withOwner: nil, options: nil)[safe: index] as? UIView
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
