//
//  PurchaseProductView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 04.06.2022.
//

import UIKit
import SnapKit

protocol PurchaseProductViewDelegate: AnyObject {
    func productSelected(view: PurchaseProductView)
}

final class PurchaseProductView: UIView {
    
    weak var delegate: PurchaseProductViewDelegate?
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "0062FF")!.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    lazy private var rangeLbl: UILabel = {
        let view = UILabel()
        view.font = .compactRoundedRegular(14.0)
        view.textColor = UIColor(hexString: "3BF06E")!
        view.textAlignment = .center
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy private var priceLbl: UILabel = {
        let view = UILabel()
        view.font = .compactRoundedSemibold(16.0)
        view.minimumScaleFactor = 0.1
        view.textColor = UIColor(hexString: "3BF06E")!
        view.textAlignment = .center
        view.numberOfLines = 0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy private var infoLbl: UILabel = {
        let view = UILabel()
        view.font = .compactRoundedMedium(12.0)
        view.textColor = UIColor(hexString: "3BF06E")!
        view.textAlignment = .center
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var tickImageView: UIImageView = {
        let profileView = UIImageView()
        profileView.clipsToBounds = true
        profileView.contentMode = .scaleAspectFill
        profileView.image = UIImage(named: "purchases_product_unselected")
        return profileView
    }()
    
    var isSelected: Bool = false {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(hexString: "0062FF")!.withAlphaComponent(0.56) : .clear
            containerView.layer.borderColor = isSelected ? UIColor(hexString: "3BF06E")!.cgColor : UIColor(hexString: "0062FF")!.cgColor
            tickImageView.image = UIImage(named: isSelected ? "purchases_product_selected" : "purchases_product_unselected")
            containerView.layer.borderWidth = isSelected ? 2 : 1
        }
    }
    
    lazy private var button: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return view
    }()
    
    @objc private func tapAction() {
        delegate?.productSelected(view: self)
    }
    
    var product: Product? {
        didSet {
            if let product = product {
                rangeLbl.text = product.name
                infoLbl.text = product.info
                priceLbl.attributedText = product.price
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        
        addSubview(containerView)
        containerView.addSubview(rangeLbl)
        containerView.addSubview(priceLbl)
        containerView.addSubview(infoLbl)
        containerView.addSubview(tickImageView)
        containerView.addSubview(button)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        rangeLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        
        infoLbl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        tickImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        isSelected = false
        
    }
}
 
