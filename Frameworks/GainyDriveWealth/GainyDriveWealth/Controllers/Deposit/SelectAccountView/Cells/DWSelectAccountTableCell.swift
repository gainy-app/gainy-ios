//
//  DWSelectAccountTableCell.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 1.11.22.
//

import UIKit
import GainyCommon

final class DWSelectAccountTableCell: UITableViewCell {
    
    static let reuseIdentifier = "selectAccountCell"
    var didTapDelete: VoidHandler?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.proDisplayBold(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let separatorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dw_dots", in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), compatibleWith: nil)
        return imageView
    }()
    
    let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Disconnect", for: .normal)
        deleteButton.setTitleColor(UIColor(hexString: "E85D5E"), for: .normal)
        deleteButton.titleLabel?.font = .compactRoundedSemibold(12)
        deleteButton.layer.borderWidth = 0.0        
        deleteButton.backgroundColor = UIColor(hexString: "F7F8F9")
        deleteButton.layer.cornerRadius = 16.0
        return deleteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.textColor = selected ? UIColor(hexString: "#09141F") : UIColor(hexString: "#B1BDC8")
        }
    }
    
    func setupUI() {
        contentView.addSubviews(titleLabel, separatorImage, deleteButton)
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            separatorImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            separatorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            separatorImage.heightAnchor.constraint(equalToConstant: 2),
            separatorImage.widthAnchor.constraint(equalToConstant: 102)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 28),
            deleteButton.widthAnchor.constraint(equalToConstant: 93),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapDeleteButton() {
        didTapDelete?()
    }
    
    func configure(with name: String, needReauth: Bool, isLast: Bool = false, isNeedToDelete: Bool = false) {
        titleLabel.text = name
        separatorImage.isHidden = isLast
        if isNeedToDelete {
            deleteButton.isHidden = false
        }
        
        if needReauth {
            deleteButton.setTitle("Reconnect", for: .normal)
            deleteButton.setTitleColor(UIColor(hexString: "FC8271"), for: .normal)
        } else {
            deleteButton.setTitle("Disconnect", for: .normal)
            deleteButton.setTitleColor(UIColor(hexString: "0062FF"), for: .normal)
        }
    }
}
