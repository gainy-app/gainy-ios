//
//  DWAccountButton.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 20.09.2022.
//

import UIKit
import SnapKit

public class DWAccountButton: UIButton {
       
    open var buttonActionHandler: ((UIButton) -> ())? = nil
    
    public enum DWAccountButtonMode {
        case info(title: String), dropdown, add
    }
    
    public var mode: DWAccountButtonMode = .info(title: "") {
        didSet {
            switch mode {
            case .info(let title):
                iconImageView.isHidden = false
                titleLbl.isHidden = false
                iconImageView.image = UIImage(name: "dw_account")
                iconImageView.snp.remakeConstraints { make in
                    make.width.equalTo(14.0)
                    make.height.equalTo(14.0)
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().offset(14)
                }
                titleLbl.text = title
                titleLbl.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().offset(32)
                    make.trailing.equalToSuperview().offset(-12)
                }
                break
            case .add:
                iconImageView.isHidden = true
                titleLbl.isHidden = false
                titleLbl.text = "+"
                titleLbl.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                break
            case .dropdown:
                iconImageView.isHidden = false
                titleLbl.isHidden = true
                iconImageView.image = UIImage(name: "dw_account_switch")
                iconImageView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                break
            }
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.isUserInteractionEnabled = false
        return iconImageView
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .proDisplaySemibold(12)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func configureWithCornerRadius(radius: Float) {
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = false
    }
    
   
    private func setupView() {
        setTitle("", for: .normal)
        backgroundColor = UIColor(hexString: "#1B45FB")
        self.configureWithCornerRadius(radius: 16.0)
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
        addTarget(self, action: #selector(touchUpInside), for: [.touchUpInside,])
        
        addSubview(iconImageView)
        addSubview(titleLbl)
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(14)
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
        }
        titleLbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-14)
        }
    }
    
    
    @objc private func touchDown() {
        
    }
    
    @objc private func touchUp() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc private func touchUpInside() {
        
        self.buttonActionHandler?(self)
    }
}
