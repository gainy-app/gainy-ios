//
//  TTFBlockView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.05.2022.
//

import UIKit
import PureLayout
import Combine

class TKPassThroughView: UIView {
    
    // MARK - Touch Handling
    
    /**
     Override this point and determine if any of the subviews of our transparent view are the ones being tapped. If that is the case, handle those touches otherwise pass the touch through.
    */
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews as [UIView] {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}

final class TTFBlockView: TKPassThroughView {
    
    enum State {
        case haveMore, noMore
    }
    
    var state: State = .haveMore {
        didSet {
            if state == .haveMore {
                amountView.backgroundColor = UIColor(hexString: "#0062FF")
                unlockBtn.setTitle("Show details".uppercased(), for: .normal)
                header.text = "Wanna check details?"
                tipLbl.text = "With a free plan, you can only view 3 TTFs per month."
            } else {
                amountView.backgroundColor = UIColor(hexString: "#F9557B")
                unlockBtn.setTitle("Unlock details".uppercased(), for: .normal)
                header.text = "Oops, you used it all."
                tipLbl.text = "You have watched 3 free TTFs this month. Switch to Gainy Premium to see Match Score and composition for all TTFs."
            }
        }
    }
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.text = "Wanna check details?"
        label.font = .compactRoundedSemibold(20)
        label.isUserInteractionEnabled = false
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    lazy var amountView: UIView = {
        let label = UIView()
        label.layer.cornerRadius = 8.0
        label.clipsToBounds = true
        label.backgroundColor = UIColor(hexString: "#0062FF")
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var amountLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.text = "0/3 opened"
        label.font = .compactRoundedSemibold(14)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var tipLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "With a free plan, you can only view 3 TTFs per month."
        label.font = .compactRoundedMedium(16)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var unlockBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .compactRoundedMedium(16)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Show details".uppercased(), for: .normal)
        btn.layer.cornerRadius = 20
        
        btn.backgroundColor = UIColor(hexString: "#1B45FB")!
        btn.layer.shadowColor = UIColor(hexString: "4484FF")!.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 24
        btn.layer.shadowOpacity = 0.64
        btn.layer.cornerRadius = 20.0
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = true
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
        
        backgroundColor = UIColor(hexString: "09141F")!.withAlphaComponent(0.88)
        layer.cornerRadius = 32.0
        clipsToBounds = true
        
        addSubview(header)
        
        header.autoPinEdge(.top, to: .top, of: self, withOffset: 24)
        header.autoPinEdge(.leading, to: .leading, of: self, withOffset: 24)
        header.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -143)
        
        addSubview(amountView)
        amountView.autoPinEdge(.top, to: .top, of: self, withOffset: 24)
        amountView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -24)
        amountView.autoSetDimension(.height, toSize: 24)
        amountView.autoSetDimension(.width, toSize: 88)
        
        amountView.addSubview(amountLbl)
        amountLbl.autoPinEdgesToSuperviewEdges(with: .init(top: 4, left: 8, bottom: 4, right: 8))
        amountLbl.autoSetDimension(.height, toSize: 16)
        
        addSubview(tipLbl)
        tipLbl.autoPinEdge(.top, to: .bottom, of: header, withOffset: 16)
        tipLbl.autoAlignAxis(toSuperviewAxis: .vertical)
        tipLbl.autoPinEdge(.leading, to: .leading, of: self, withOffset: 24)
        tipLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -24)
        
        addSubview(unlockBtn)
        unlockBtn.autoPinEdge(.top, to: .bottom, of: tipLbl, withOffset: 24)
        unlockBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        unlockBtn.autoPinEdge(.leading, to: .leading, of: self, withOffset: 24)
        unlockBtn.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -24)
        unlockBtn.autoSetDimension(.height, toSize: 48)
        unlockBtn.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -24)
        
        SubscriptionManager.shared.storage.collectionsViewedPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] count in
            if count == SubscriptionManager.shared.storage.collectionViewLimit {
                self?.state = .noMore
            } else {
                self?.state = .haveMore
            }
                self?.amountLbl.text = "\(count)/\(SubscriptionManager.shared.storage.collectionViewLimit) opened"
        }.store(in: &cancellable)
    }
}
