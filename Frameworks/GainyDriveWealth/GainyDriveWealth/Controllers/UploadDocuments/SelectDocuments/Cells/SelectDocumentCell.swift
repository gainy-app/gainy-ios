//
//  SelectDocumentCell.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 23.11.22.
//

import UIKit

class SelectDocumentCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: SelectDocumentCell.self)
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.proDisplayMedium(16)
        }
    }
    @IBOutlet weak var stateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stateImage.image = UIImage(named: "dw_add_document", in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), with: .none)
    }
    
    func configure(title: String, state: Bool = false) {
        titleLabel.text = title
        if state {
            stateImage.image = UIImage(named: "dw_added_document", in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), with: .none)
        }
    }
}
