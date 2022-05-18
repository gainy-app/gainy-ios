//
//  TTFBlockView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.05.2022.
//

import UIKit
import PureLayout
import Combine

final class TTFBlockView: UIView {
    
    enum State {
        case haveMore, noMore
    }
    
    var state: State = .haveMore {
        didSet {
            if state == .haveMore {
                amountView.backgroundColor = UIColor(hexString: "#0062FF")
            } else {
                amountView.backgroundColor = UIColor(hexString: "#F9557B")
            }
        }
    }
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.Gainy.mainText
        label.text = "Wanna check details?"
        label.font = .proDisplaySemibold(20.0)
        return label
    }()
    
    lazy var amountView: UIView = {
        let label = UIView()
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        label.backgroundColor = UIColor(hexString: "#0062FF")
        return label
    }()
    
    lazy var amountLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.Gainy.mainText
        label.text = "3 / 3 TTFs opened"
        label.font = .compactRoundedSemibold(14)
        return label
    }()
    
    lazy var tipLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.Gainy.mainText
        label.text = "3 / 3 TTFs opened"
        label.font = .compactRoundedMedium(14)
        return label
    }()
    
    lazy var unlockBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor(hexString: "3BF06E"), for: .normal)
        btn.setTitle("Show details".uppercased(), for: .normal)
        btn.layer.cornerRadius = 20
    
        let backGradientView = GradientBackgroundView()
        backGradientView.startColor = UIColor(hexString: "1B44F7")
        backGradientView.endColor = UIColor(hexString: "5ACEFF")
        btn.addSubview(backGradientView)
        backGradientView.autoPinEdgesToSuperviewEdges()
        
        btn.layer.shadowColor = UIColor(hexString: "4484FF")!.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 24
        btn.layer.shadowOpacity = 0.64
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    fileprivate func setupView() {
        addSubview(header)
        
        header.autoPinEdge(.top, to: .top, of: self, withOffset: 20)
        header.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(amountView)
        amountView.autoPinEdge(.top, to: .bottom, of: header, withOffset: 16)
        amountView.autoAlignAxis(toSuperviewAxis: .vertical)
        amountView.autoSetDimension(.height, toSize: 24)
        
        amountView.addSubview(amountLbl)
        amountLbl.autoPinEdgesToSuperviewEdges(with: .init(top: 4, left: 8, bottom: 4, right: 8))
        amountLbl.autoSetDimension(.height, toSize: 16)
        
        addSubview(tipLbl)
        tipLbl.autoPinEdge(.top, to: .top, of: amountView, withOffset: 16)
        tipLbl.autoAlignAxis(toSuperviewAxis: .vertical)
        tipLbl.autoPinEdge(.leading, to: .leading, of: self, withOffset: 24)
        tipLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -24)
        
        addSubview(unlockBtn)
        amountView.autoPinEdge(.top, to: .bottom, of: tipLbl, withOffset: 16)
        amountView.autoAlignAxis(toSuperviewAxis: .vertical)
        tipLbl.autoPinEdge(.leading, to: .leading, of: self, withOffset: 32)
        tipLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        amountView.autoSetDimension(.height, toSize: 64)
        
        SubscriptionManager.shared.storage.collectionsViewedPublisher.sink { count in
            print("count")
        }.store(in: &cancellable)
    }
}
