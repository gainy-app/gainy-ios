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
        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.isHidden = true
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
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            separatorImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            separatorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            separatorImage.heightAnchor.constraint(equalToConstant: 2),
            separatorImage.widthAnchor.constraint(equalToConstant: 102)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 25),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapDeleteButton() {
        didTapDelete?()
    }
    
    func configure(with name: String, isLast: Bool = false, isNeedToDelete: Bool = false) {
        titleLabel.text = name
        separatorImage.isHidden = isLast
        if isNeedToDelete {
            deleteButton.isHidden = false
        }
    }
}
