//
//  PromoPurchasesProductsView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 14.06.2022.
//

import UIKit
import SnapKit

protocol PromoPurchasesProductsViewDelegate: AnyObject {
    func applyPromo(view: PromoPurchasesProductsView)
}

final class PromoPurchasesProductsView: UIView {
    
    weak var delegate: PromoPurchasesProductsViewDelegate?
    
    /// Selected Product to buy
    var selectedProduct: Product? {
        get {
            productView.product
        }
        set {
            productView.product = newValue
        }
    }
    
    var promoCode: String {
        promoField.text ?? ""
    }
    
    var blockUI: Bool = false {
        didSet {
            applyBtn.isEnabled = !blockUI
            promoField.isEnabled = !blockUI
        }
    }
    
    lazy private var productView: PromoPurchaseProductView = {
        let productView = PromoPurchaseProductView()
        productView.product = .year(RemoteConfigManager.shared.yearPurchaseVariant ?? .a)
        return productView
    }()
    
    lazy private var applyBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .compactRoundedSemibold(12)
        btn.setTitleColor(UIColor.Gainy.mainText, for: .normal)
        btn.setTitle("Apply", for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(hexString: "3BF06E")
        btn.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
        return btn
    }()
    
    lazy private var promoContainer: UIView = {
        let promoContainer = UIView()
        promoContainer.clipsToBounds = false
        promoContainer.layer.cornerRadius = 16
        promoContainer.backgroundColor = UIColor(hexString: "0062FF")!.withAlphaComponent(0.56)
        promoContainer.layer.borderColor = UIColor(hexString: "3BF06E")!.cgColor
        promoContainer.layer.borderWidth = 1
        return promoContainer
    }()
    
    lazy private var promoField: UITextField = {
        let promoField = UITextField()
        promoField.backgroundColor = .clear
        promoField.font = .compactRoundedMedium(12.0)
        promoField.textColor = .white
        promoField.attributedPlaceholder = NSAttributedString(string: "Enter promocode", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        return promoField
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
        addSubview(productView)
        addSubview(promoContainer)
        addSubview(applyBtn)
        promoContainer.addSubview(promoField)
        
        productView.snp.makeConstraints { make in
            make.height.equalTo(72.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        promoContainer.snp.makeConstraints { make in
            make.height.equalTo(32.0)
            make.leading.equalToSuperview()
            make.trailing.equalTo(applyBtn.snp.leading).offset(-8.0)
            make.bottom.equalToSuperview()
        }
        
        applyBtn.snp.makeConstraints { make in
            make.height.equalTo(32.0)
            make.width.equalTo(104)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        promoField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    //MARK:- Actions
    
    @objc private func applyAction() {
        delegate?.applyPromo(view: self)
    }
}
