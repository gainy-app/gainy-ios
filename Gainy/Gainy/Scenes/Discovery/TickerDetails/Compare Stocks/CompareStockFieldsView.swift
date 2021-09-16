//
//  CompareStockFieldsView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.09.2021.
//

import UIKit
import PureLayout

class CompareStockFieldsView: UIView {
    
    private let fields = ["Stock price", MarketDataField.evs.title, MarketDataField.growsRateYOY.title, MarketDataField.netProfit.title, MarketDataField.marketCap.title, MarketDataField.monthToDay.title ]
    
    private func makeBtn(_ title: String) -> ResponsiveButton {
        let btn = ResponsiveButton()
        btn.titleLabel?.font = .proDisplaySemibold(16)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(named: "mainText"), for: .selected)
        btn.setTitleColor(UIColor(hexString: "B1BDC8"), for: .normal)
        return btn
    }
    
    lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainText")
        view.layer.cornerRadius = 3.0 / 2.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    /// Inner bu
    fileprivate var innerBtns: [ResponsiveButton] = []
    
    fileprivate var indConstraints: [NSLayoutConstraint] = []
    
    fileprivate func setupView() {
        for (ind, title) in fields.enumerated() {
            let btn = makeBtn(title)
            addSubview(btn)
            innerBtns.append(btn)
            
            btn.autoPinEdge(.top, to: .top, of: self)
            btn.autoSetDimension(.height, toSize: 20.0)
            if ind == 0 {
                btn.isSelected = true
                btn.autoPinEdge(.leading, to: .leading, of: self, withOffset: 28.0)
            } else {
                btn.autoPinEdge(.leading, to: .trailing, of: innerBtns[innerBtns.count - 2], withOffset: 20)
            }
            
            btn.tag = ind
            btn.addTarget(self, action: #selector(btnSelected(_:)), for: .touchUpInside)
        }
        
        addSubview(indicator)
        indicator.autoPinEdge(.top, to: .bottom, of: innerBtns.first!, withOffset: 3)
        indicator.autoSetDimension(.height, toSize: 3.0)
        
        let left = indicator.autoPinEdge(.left, to: .left, of: innerBtns.first!)
        let right = indicator.autoPinEdge(.right, to: .right, of: innerBtns.first!)
        indConstraints.append(left)
        indConstraints.append(right)
    }
    
    //MARK: - Actions
    
    @objc func btnSelected(_ sender: ResponsiveButton) {
        innerBtns.forEach({$0.isSelected = false})
        sender.isSelected = true
        
        indConstraints.forEach({
            self.removeConstraint($0)
        })
        
        let left = indicator.autoPinEdge(.left, to: .left, of: sender)
        let right = indicator.autoPinEdge(.right, to: .right, of: sender)
        indConstraints.append(left)
        indConstraints.append(right)
        
        if let scroll = self.superview as? UIScrollView {
            scroll.scrollRectToVisible(sender.frame.insetBy(dx: -20, dy: -20), animated: true)
        }
    }
}
