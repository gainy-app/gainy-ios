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
    case pageControl
}

public class GainyNavigationBar: UIView {
    
    open var closeActionHandler: ((UIButton) -> ())? = nil
    open var backActionHandler: ((UIButton) -> ())? = nil
    
    private var pageControl: GainyPageControl?
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
    
    public func setupWithCurrentPage(currentPage: Int, maxPages: Int) {
        self.pageControl?.numberOfPages = maxPages
        self.pageControl?.currentPage = currentPage
    }
    
    public func configureWithItems(items: [GainyNavigationBarItem]) {
        
        self.closeButton?.isHidden = true
        self.backButton?.isHidden = true
        self.pageControl?.isHidden = true
        
        for item in items {
            switch item {
            case .back: self.backButton?.isHidden = false
            case .close: self.closeButton?.isHidden = false
            case .pageControl: self.pageControl?.isHidden = false
            }
        }
    }
    
    private func setupView() {
       
        let closeButton = GainyButton.newAutoLayout()
        self.addSubview(closeButton)
        closeButton.autoSetDimensions(to: CGSize(width: 44.0, height: 44.0))
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 12.0)
        closeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 14.0)
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
        
        let pageControl = GainyPageControl.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 24), numberOfPages: 8)
        pageControl.currentPage = 1
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hideForSinglePage = true
        self.addSubview(pageControl)
        pageControl.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        pageControl.autoPinEdge(toSuperviewEdge: .top, withInset: 21.0)
        pageControl.autoSetDimension(.height, toSize: 24.0)
        pageControl.isHidden = true
        self.pageControl = pageControl
    }
}
