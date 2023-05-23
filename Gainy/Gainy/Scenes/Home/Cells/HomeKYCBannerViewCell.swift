//
//  HomeKYCBannerViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.05.2023.
//

import UIKit
import SnapKit
import GainyCommon

protocol HomeKYCBannerViewCellDelegate: AnyObject {
    func closeKycAction()
    func kycActionTapped(type: HomeKYCBannerViewCell.HomeKYCBannerType)
}

final class HomeKYCBannerViewCell: UITableViewCell {
    
    static func heightForType(_ type: HomeKYCBannerType) -> CGFloat {
        switch type {
            
        case .startKyc, .uploadDoc, .deposit:
            return 136.0
        case .continueKyc:
            return 156.0
        case .needInfo(let lines):
            var title = "Please review and correct the following information:"
            for line in lines {
                title.append("\n→ \(line.title)")
            }
            return 48.0 + title.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 40.0 - 119.0, font: .proDisplaySemibold(16)) + 72.0
        case .pending:
            return 204.0
        }
    }
    
    enum HomeKYCBannerType {
        case startKyc, continueKyc, uploadDoc, needInfo(lines: [KYCErrorCode]), deposit, pending
    }
    
    var type: HomeKYCBannerType = .startKyc {
        didSet {
            switch type {
            case .startKyc:
                nameLabel.text = "First step to set up your\nbrokerage account"
                dashView.image = UIImage(named: "no_porto_back")
                logoImgView.image = UIImage(named: "home_kyc_astro")
                nameLabel.textColor = .white
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(16.0)
                    make.trailing.equalToSuperview()
                    make.bottom.equalToSuperview()
                })
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(24.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                pendingTitle.isHidden = true
                pendingTag.isHidden = true
                closeBtn.setImage(UIImage(named: "home_kyc_close"), for: .normal)
                break
            case .continueKyc:
                nameLabel.text = "You are halfway through\nopening a brokerage\naccount"
                dashView.image = UIImage(named: "no_porto_back")
                logoImgView.image = UIImage(named: "home_kyc_astro")
                nameLabel.textColor = .white
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(16.0)
                    make.trailing.equalToSuperview()
                    make.bottom.equalToSuperview()
                })
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(24.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                pendingTitle.isHidden = true
                pendingTag.isHidden = true
                closeBtn.setImage(UIImage(named: "home_kyc_close"), for: .normal)
                break
            case .uploadDoc:
                nameLabel.text = "Additional documents are\nrequired to open account"
                dashView.image = nil
                logoImgView.image = UIImage(named: "home_kyc_docs")
                nameLabel.textColor = UIColor.Gainy.mainText
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.width.equalTo(104)
                    make.height.equalTo(120)
                })
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(24.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                pendingTitle.isHidden = true
                pendingTag.isHidden = true
                closeBtn.setImage(UIImage(named: "home_kyc_close_black"), for: .normal)
                break
            case .needInfo(let lines):
                var title = "Please review and correct the following information:"
                for line in lines {
                    title.append("\n→ \(line.title)")
                }
                nameLabel.text = title
                dashView.image = nil
                logoImgView.image = UIImage(named: "home_kyc_need_info")
                nameLabel.textColor = UIColor.Gainy.mainText
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.width.equalTo(56)
                    make.height.equalTo(72)
                })
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(24.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                pendingTitle.isHidden = true
                pendingTag.isHidden = true
                closeBtn.setImage(UIImage(named: "home_kyc_close_black"), for: .normal)
                break
            case .deposit:
                nameLabel.text = "Additional documents are\nrequired to open account"
                dashView.image = UIImage(named: "no_porto_back")
                logoImgView.image = UIImage(named: "home_kyc_deposit")
                nameLabel.textColor = .white
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(32)
                    make.trailing.equalToSuperview().offset(-32)
                    make.width.equalTo(64)
                    make.height.equalTo(64)
                })
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(24.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                pendingTitle.isHidden = true
                pendingTag.isHidden = true
                closeBtn.setImage(UIImage(named: "home_kyc_close"), for: .normal)
                break
            case .pending:
                nameLabel.text = "Thanks for your time! Stay\ntuned until you are approved."
                dashView.image = nil
                logoImgView.image = UIImage(named: "home_kyc_docs")
                nameLabel.textColor = UIColor.Gainy.mainText
                requestBtn.setTitle("Go to form", for: .normal)
                requestBtn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
                logoImgView.snp.remakeConstraints( {make in
                    make.top.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.width.equalTo(104)
                    make.height.equalTo(120)
                })
                
                nameLabel.snp.remakeConstraints( {make in
                    make.top.equalToSuperview().offset(92.0)
                    make.leading.equalToSuperview().offset(24.0)
                    make.trailing.equalToSuperview().offset(-135.0)
                })
                
                pendingTitle.isHidden = false
                pendingTag.isHidden = false
                closeBtn.setImage(UIImage(named: "home_kyc_close_black"), for: .normal)
                break
            }
        }
    }
    
    weak var delegate: HomeKYCBannerViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            make.bottom.equalToSuperview() 
        })
        
        dashView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(24.0)
            make.leading.equalToSuperview().offset(24.0)
            make.trailing.equalToSuperview().offset(-135.0)
        })
        
        dashView.addSubview(pendingTitle)
        pendingTitle.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(24.0)
            make.leading.equalToSuperview().offset(24.0)
        })
        
        dashView.addSubview(pendingTag)
        pendingTag.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(56.0)
            make.leading.equalToSuperview().offset(24.0)
            make.width.equalTo(75.0)
            make.height.equalTo(24.0)
        })
        
        dashView.addSubview(logoImgView)
        logoImgView.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(16.0)
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
        
        contentView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-36.0)
            make.width.equalTo(24.0)
            make.height.equalTo(24.0)
        })
    }
    
    lazy var dashView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "no_porto_back")
        view.contentMode = .redraw
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "F3F3F3")
        return view
    }()
    
    lazy var pendingTitle: UILabel = {
        let label = UILabel()
        label.font = .proDisplayBold(16)
        label.textColor = UIColor.Gainy.mainText
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.text = "Your application"
        label.isHidden = true
        return label
    }()
    
    lazy var pendingTag: UILabel = {
        let label = UILabel()
        label.font = .compactRoundedSemibold(12)
        label.textColor = UIColor.Gainy.mainText
        label.backgroundColor = .white
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.text = "PENDING"
        label.layer.cornerRadius = 12.0
        label.clipsToBounds = true
        label.isHidden = true
        return label
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
        btn.setTitleColor(UIColor(hexString: "#1B45FB"), for: .normal)
        btn.backgroundColor = UIColor(hexString: "#DCF64F")
        btn.setTitle("Take me on board!", for: .normal)
        btn.layer.cornerRadius = 8.0
        btn.addTarget(self, action: #selector(requestBannerAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var logoImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "home_kyc_astro")
        view.contentMode = .topRight
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_kyc_close"), for: .normal)
        btn.addTarget(self, action: #selector(closeBannerAction), for: .touchUpInside)
        return btn
    }()
    
    
    //MARK: - Actions
    
    @objc func closeBannerAction() {
        delegate?.closeKycAction()
    }
    
    @objc func requestBannerAction() {
        delegate?.kycActionTapped(type: type)
    }
}
