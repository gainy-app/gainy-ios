//
//  HomeDynamicView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 14.01.2023.
//

import UIKit

enum HomeDynamicViewMode {
    case none, balance, notifs, balanceWithNotifs
}

final class HomeDynamicView: UIView {
    
    @IBOutlet weak var balanceView: HomeShadowView!
    @IBOutlet weak var balanceBackView: UIImageView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var dynamicBottom: NSLayoutConstraint!
    @IBOutlet weak var dynamicTop: NSLayoutConstraint!
    @IBOutlet weak var notificationsView: HomeNotificationsView!
    
    var mode: HomeDynamicViewMode = .none {
        didSet {
            switch mode {
            case .none:
                self.isHidden = true
                dynamicTop.constant = 0
                dynamicBottom.constant = 0
                balanceView.isHidden = true
                notificationsView.isHidden = true
                break
            case .balance:
                dynamicTop.constant = 0
                dynamicBottom.constant = 20
                self.isHidden = false
                balanceView.isHidden = false
                notificationsView.isHidden = true
                balanceBackView.image = UIImage(named: "home_notifs_bg")
            case .notifs:
                dynamicTop.constant = 0
                dynamicBottom.constant = 20
                self.isHidden = false
                balanceView.isHidden = true
                notificationsView.isHidden = false
                balanceBackView.image = UIImage(named: "home_notifs_bg")
            case .balanceWithNotifs:
                dynamicTop.constant = 0
                dynamicBottom.constant = 20
                self.isHidden = false
                balanceView.isHidden = false
                notificationsView.isHidden = false
                balanceBackView.image = UIImage(named: "home_notifs_large_bg")
            }
            viewHeight.constant = heightForMode()
            layoutIfNeeded()
        }
    }
    

    func heightForMode() -> CGFloat {
        switch mode {
        case .none:
            return 0.0
        case .balance:
            return 80.0 + 16.0
        case .notifs:
            return 160.0
        case .balanceWithNotifs:
            return 248.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 16.0
        backgroundColor = .clear
        clipsToBounds = true
    }
    
}
