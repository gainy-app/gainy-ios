//
//  PurchasesProductsView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 04.06.2022.
//

import UIKit
import SnapKit

final class PurchasesProductsView: UIView {
    
    /// Selected Product to buy
    var selectedProduct: Product? {
        if firstProductView.isSelected {
            return firstProductView.product
        } else {
            if secondProductView.isSelected {
                return secondProductView.product
            } else {
                return thirdProductView.product
            }
        }
    }
    
    lazy private var firstProductView: PurchaseProductView = {
        let productView = PurchaseProductView()
        productView.product = .month(RemoteConfigManager.shared.monthPurchaseVariant ?? .a)
        productView.delegate = self
        return productView
    }()
    
    lazy private var secondProductView: PurchaseProductView = {
        let productView = PurchaseProductView()
        productView.product = .month6(RemoteConfigManager.shared.month6PurchaseVariant ?? .a)
        productView.delegate = self
        return productView
    }()
    
    lazy private var thirdProductView: PurchaseProductView = {
        let productView = PurchaseProductView()
        productView.product = .year(RemoteConfigManager.shared.yearPurchaseVariant ?? .a)
        productView.delegate = self
        return productView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        addSubview(firstProductView)
        addSubview(secondProductView)
        addSubview(thirdProductView)
        
        firstProductView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.33).offset(-4)
        }
        
        secondProductView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.33).offset(-4)
        }
        
        thirdProductView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.33).offset(-4)
        }
        
        secondProductView.isSelected = true
    }
}

extension PurchasesProductsView: PurchaseProductViewDelegate {
    func productSelected(view: PurchaseProductView) {
        
        firstProductView.isSelected = false
        secondProductView.isSelected = false
        thirdProductView.isSelected = false
        view.isSelected = true
    }
}
