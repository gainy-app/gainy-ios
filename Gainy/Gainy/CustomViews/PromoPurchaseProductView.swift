//
//  PromoPurchaseProductView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 14.06.2022.
//

import UIKit
import SnapKit

final class PromoPurchaseProductView: UIView {
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "0062FF")!.cgColor
        view.backgroundColor = .clear
        return view
    }()
    
    lazy private var rangeLbl: UILabel = {
        let view = UILabel()
        view.font = .compactRoundedSemibold(16.0)
        view.textColor = UIColor(hexString: "3BF06E")!
        view.text = "Send your friend a free month\nand you'll get one too"
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    lazy private var infoLbl: UILabel = {
        let view = UILabel()
        view.font = .compactRoundedMedium(12.0)
        view.textColor = UIColor(hexString: "3BF06E")!
        view.text = "per year subscription"
        view.textAlignment = .center
        return view
    }()
    
    lazy var tickImageView: UIImageView = {
        let profileView = UIImageView()
        profileView.clipsToBounds = true
        profileView.contentMode = .scaleAspectFill
        profileView.image = UIImage(named: "purchases_product_unselected")
        return profileView
    }()
    
    var product: Product? {
        didSet {
            if let product = product {
                rangeLbl.text = "Get the hole Year for \(product.price) only!"
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
        containerView.addSubview(infoLbl)
        containerView.addSubview(tickImageView)
        
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
        
        containerView.backgroundColor = UIColor(hexString: "0062FF")!.withAlphaComponent(0.56)
        containerView.layer.borderColor = UIColor(hexString: "3BF06E")!.cgColor
        tickImageView.image = UIImage(named: "purchases_product_selected" )
        
        containerView.layer.borderWidth = 1
        
    }
}
