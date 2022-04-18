//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionDetailsRecommendedCell: UICollectionViewCell {
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Gainy.mainGreen
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func configureWith(companyName: String) {

    }
}
