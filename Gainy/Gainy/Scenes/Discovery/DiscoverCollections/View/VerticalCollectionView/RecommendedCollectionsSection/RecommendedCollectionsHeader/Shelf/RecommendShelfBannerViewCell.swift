//
//  RecommendShelfBannerViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.05.2023.
//

import UIKit
import SnapKit
import GainyCommon

final class RecommendShelfBannerViewCell: RoundedCollectionViewCell {
    
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
        
        dashView.addSubview(requestBtn)
        requestBtn.snp.makeConstraints( {make in
            make.bottom.equalToSuperview().offset(-24.0)
            make.leading.equalToSuperview().offset(24.0)
            make.width.equalTo(136.0)
            make.height.equalTo(32)
        })
        
        dashView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(24.0)
            make.leading.equalToSuperview().offset(24.0)
            make.trailing.equalToSuperview().offset(-135.0)
        })
        
        dashView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.width.equalTo(24.0)
            make.height.equalTo(24.0)
        })
        
        dashView.addSubview(logoImgView)
        logoImgView.snp.makeConstraints( {make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(136)
            make.height.equalTo(136)
        })
    }
    
    lazy var dashView: UIImageView = {
        let view = UIImageView()
        view.image = nil
        view.contentMode = .redraw
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "F3F3F3")
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplayMedium(16)
        label.textColor = UIColor.Gainy.mainText
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.text = "Can’t find what you want to invest in?"
        return label
    }()
    
    lazy var requestBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .proDisplaySemibold(13.0)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hexString: "1B45FB")
        btn.setTitle("Request it", for: .normal)
        btn.layer.cornerRadius = 8.0
        btn.addTarget(self, action: #selector(requestBannerAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_kyc_close_black"), for: .normal)
        btn.addTarget(self, action: #selector(closeBannerAction), for: .touchUpInside)
        return btn
    }()
    
    
lazy var logoImgView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "disco_search_banner")
    return view
}()
    
    //MARK: - Actions
    
    @objc func closeBannerAction() {
        delegate?.bannerClosePressed()
    }
    
    @objc func requestBannerAction() {
        delegate?.bannerRequestPressed()
    }
}
        
