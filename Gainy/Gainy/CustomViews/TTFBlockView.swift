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

protocol TTFBlockViewDelegate: AnyObject {
    func unlockButtonTapped(showPurchase: Bool)
}

final class TTFBlockView: TKPassThroughView {
    
    weak var delegate: TTFBlockViewDelegate?
    
    enum State {
        case haveMore, noMore
    }
    
    var state: State = .haveMore {
        didSet {
            if state == .haveMore {
                amountView.backgroundColor = UIColor(hexString: "#0062FF")
                unlockBtn.setTitle("Show details".uppercased(), for: .normal)
                header.text = "Wanna check details?"
                tipLbl.text = "With a free plan, you can only view\n3 TTFs per month."
            } else {
                amountView.backgroundColor = UIColor(hexString: "#F9557B")
                unlockBtn.setTitle("Unlock details".uppercased(), for: .normal)
                header.text = "Oops, you used it all."
                tipLbl.text = "You have watched 3 free TTFs this month.\nSwitch to Gainy Premium to see Match Score\nand composition for all TTFs."
            }
        }
    }
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.Gainy.mainText
        label.text = "Wanna check details?"
        label.font = .proDisplaySemibold(20.0)
        label.isUserInteractionEnabled = false
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
        label.text = "3 / 3 TTFs opened"
        label.font = .compactRoundedSemibold(14)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var tipLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.Gainy.mainText
        label.text = "With a free plan, you can only view\n3 TTFs per month."
        label.font = .compactRoundedMedium(16)
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var unlockBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor(hexString: "3BF06E"), for: .normal)
        btn.setTitle("Show details".uppercased(), for: .normal)
        btn.layer.cornerRadius = 20
    
        let backGradientView = GradientPlainBackgroundView()
        backGradientView.startColor = UIColor(hexString: "1B44F7")
        backGradientView.endColor = UIColor(hexString: "357CFD")
        backGradientView.startPoint = .init(x: 0, y: 0.5)
        backGradientView.endPoint = .init(x: 1, y: 0.5)
        btn.addSubview(backGradientView)
        backGradientView.autoPinEdgesToSuperviewEdges()
        
        btn.backgroundColor = UIColor(hexString: "#1B45FB")!
        btn.layer.shadowColor = UIColor(hexString: "4484FF")!.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 24
        btn.layer.shadowOpacity = 0.64
        btn.layer.cornerRadius = 20.0
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = true
        
        btn.addTarget(self, action: #selector(unlockAction), for: .touchUpInside)
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
        tipLbl.autoPinEdge(.top, to: .bottom, of: amountView, withOffset: 16)
        tipLbl.autoAlignAxis(toSuperviewAxis: .vertical)
        tipLbl.autoPinEdge(.leading, to: .leading, of: self, withOffset: 24)
        tipLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -24)
        
        addSubview(unlockBtn)
        unlockBtn.autoPinEdge(.top, to: .bottom, of: tipLbl, withOffset: 40)
        unlockBtn.autoAlignAxis(toSuperviewAxis: .vertical)
        unlockBtn.autoPinEdge(.leading, to: .leading, of: self, withOffset: 32)
        unlockBtn.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        unlockBtn.autoSetDimension(.height, toSize: 56)
        unlockBtn.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -16)
        
        SubscriptionManager.shared.storage.collectionsViewedPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] count in
            if count == SubscriptionManager.shared.storage.collectionViewLimit {
                self?.state = .noMore
            } else {
                self?.state = .haveMore
            }
                self?.amountLbl.text = "\(count) / \(SubscriptionManager.shared.storage.collectionViewLimit) TTFs opened"
        }.store(in: &cancellable)
        
        amountLbl.text = "\(SubscriptionManager.shared.storage.viewedCount) / \(SubscriptionManager.shared.storage.collectionViewLimit) TTFs opened"
        state = SubscriptionManager.shared.storage.viewedCount == SubscriptionManager.shared.storage.collectionViewLimit ? .noMore : .haveMore
    }
    
    @objc func unlockAction() {
        delegate?.unlockButtonTapped(showPurchase: state == .noMore)
    }
}
