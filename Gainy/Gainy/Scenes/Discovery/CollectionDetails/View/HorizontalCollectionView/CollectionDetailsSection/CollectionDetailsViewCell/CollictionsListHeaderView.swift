//
//  CollictionsListHeaderView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 27.08.2021.
//

import UIKit
import PureLayout

class CollictionsListHeaderView: UIView {
    
    lazy var tickerLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "STOCK\nTICKER"
        return label
    }()
    
    lazy var mlpLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "MLP or\nNOT".uppercased()
        return label
    }()
    
    lazy var capLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Market\ncap".uppercased()
        return label
    }()
    
    lazy var peLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "PE\n"
        return label
    }()
    
    lazy var yieldLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Dividend\nYield".uppercased()
        return label
    }()
    
    lazy var growLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(9)
        label.textColor = UIColor(hexString: "687379")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Dividend\ngrowth".uppercased()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    fileprivate func setupView() {
        addSubview(tickerLbl)
        tickerLbl.autoSetDimensions(to: CGSize.init(width: 40, height: 24))
        tickerLbl.autoPinEdge(.left, to: .left, of: self, withOffset: 0)
        tickerLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(mlpLbl)
        mlpLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        mlpLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 0)
        mlpLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(capLbl)
        capLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        capLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -63.0 + 17)
        capLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(peLbl)
        peLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        peLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -111.0 + 17)
        peLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(yieldLbl)
        yieldLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        yieldLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -159.0 + 17)
        yieldLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(growLbl)
        growLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        growLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -207.0 + 17)
        growLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
    }
    
}
