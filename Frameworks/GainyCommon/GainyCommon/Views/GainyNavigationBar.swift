//
//  GainyNavigationBar.swift
//  GainyCommon
//
//  Created by Serhii Borysov on 9/12/22.
//

import UIKit

public enum GainyNavigationBarItem: Int {
    case back = 0
    case close
    case mainMenu
}

public class GainyNavigationBar: UIView {
    
    open var closeActionHandler: ((UIButton) -> ())? = nil
    open var backActionHandler: ((UIButton) -> ())? = nil
    open var mainMenuActionHandler: ((UIButton) -> ())? = nil
    
    private var mainMenuButton: GainyButton?
    private var backButton: GainyButton?
    private var closeButton: GainyButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func configureWithItems(items: [GainyNavigationBarItem]) {
        
        self.closeButton?.isHidden = true
        self.backButton?.isHidden = true
        self.mainMenuButton?.isHidden = true
        
        for item in items {
            switch item {
            case .back: self.backButton?.isHidden = false
            case .close: self.closeButton?.isHidden = false
            case .mainMenu: self.mainMenuButton?.isHidden = false
            }
        }
    }
    
    private func setupView() {
       
        let closeButton = GainyButton.newAutoLayout()
        self.addSubview(closeButton)
        closeButton.autoSetDimensions(to: CGSize(width: 44.0, height: 44.0))
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 12.0)
        closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        closeButton.setImage(UIImage(name: "common_close"), for: .normal)
        closeButton.buttonActionHandler = { sender in
            self.closeActionHandler?(closeButton)
        }
        closeButton.isHidden = true
        closeButton.configureWithCornerRadius(radius: 0.0)
        closeButton.configureWithBackgroundColor(color: UIColor.clear)
        closeButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        self.closeButton = closeButton
        
        
        let backButton = GainyButton.newAutoLayout()
        self.addSubview(backButton)
        backButton.autoSetDimensions(to: CGSize(width: 24.0, height: 24.0))
        backButton.autoPinEdge(toSuperviewEdge: .top, withInset: 22.0)
        backButton.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        backButton.setImage(UIImage(name: "common_back"), for: .normal)
        backButton.configureWithCornerRadius(radius: 0.0)
        backButton.configureWithBackgroundColor(color: UIColor.clear)
        backButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        backButton.buttonActionHandler = { sender in
            self.backActionHandler?(backButton)
        }
        backButton.isHidden = true
        self.backButton = backButton
        
        let mainMenuButton = GainyButton.newAutoLayout()
        self.addSubview(mainMenuButton)
        mainMenuButton.autoSetDimensions(to: CGSize(width: 24.0, height: 24.0))
        mainMenuButton.autoPinEdge(toSuperviewEdge: .top, withInset: 22.0)
        mainMenuButton.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        mainMenuButton.setImage(UIImage(name: "commom_main_menu"), for: .normal)
        mainMenuButton.configureWithCornerRadius(radius: 0.0)
        mainMenuButton.configureWithBackgroundColor(color: UIColor.clear)
        mainMenuButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        mainMenuButton.buttonActionHandler = { sender in
            self.mainMenuActionHandler?(mainMenuButton)
        }
        mainMenuButton.isHidden = true
        self.mainMenuButton = mainMenuButton
    }
}
