//
//  RecommendMSBannerViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.05.2023.
//

import UIKit
import SnapKit
import GainyCommon

final class RecommendMSBannerViewCell: RoundedCollectionViewCell {
    
    weak var delegate: DiscoveryGridItemActionable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        contentView.addSubview(dashView)
        dashView.snp.makeConstraints( {make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16.0)
            make.leading.equalToSuperview().offset(16.0)
            make.height.equalTo(136.0)
        })
        
        dashView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(24.0)
            make.leading.equalToSuperview().offset(24.0)
            make.trailing.equalToSuperview().offset(-135.0)
        })
        
        dashView.addSubview(logoImgView)
        logoImgView.snp.makeConstraints( {make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        contentView.addSubview(requestBtn)
        requestBtn.snp.makeConstraints( {make in
            make.bottom.equalToSuperview().offset(-24.0)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(136.0)
            make.height.equalTo(32)
        })
    }
    
    lazy var dashView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "no_porto_back")
        view.contentMode = .redraw
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayMedium(16)
        label.textColor = .white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.text = "Want to know you\nmatching score profile?"
        return label
    }()
    
    lazy var requestBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .proDisplaySemibold(13.0)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(hexString: "#DCF64F")
        btn.setTitle("Take me on board!", for: .normal)
        btn.layer.cornerRadius = 8.0
        btn.addTarget(self, action: #selector(requestBannerAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var logoImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "profile_plaid_hello")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    //MARK: - Actions
    
    
    @objc func requestBannerAction() {
        delegate?.msRequestPressed()
    }
}
        