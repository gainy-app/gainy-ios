//
//  UploadDocumentCell.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 24.11.22.
//

import Foundation
import UIKit

class UploadDocumentCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: UploadDocumentCell.self)
    
    @IBOutlet private weak var uploadView: UIView!
    @IBOutlet private weak var uploadLabel: UILabel! {
        didSet {
            uploadLabel.font = UIFont.proDisplayMedium(16)
        }
    }
    @IBOutlet private weak var uploadImage: UIImageView!
    @IBOutlet private weak var previewImage: UIImageView!
    
    var dashBorder: CAShapeLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16.0
        uploadView.layer.cornerRadius = 24
    }
    
    func configure(with model: UploadDocumentDisplayModel) {
        uploadLabel.text = model.documentSide.rawValue
        if model.document != nil {
            UIView.animate(withDuration: 0.4) {
                self.uploadView.backgroundColor = UIColor(hexString: "38CF92")
            }
            UIView.transition(with: uploadImage,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                self.uploadImage.image = UIImage(named: "upload_document_done", in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), with: .none)
            },
                              completion: nil)
            previewImage.image = model.displayImage
            dashBorder?.removeFromSuperlayer()
        } else {
            previewImage.image = nil
            addDashedBorder()
        }
        
        if model.isError {
            UIView.animate(withDuration: 0.5) {
                self.dashBorder?.strokeColor = UIColor(hexString: "F95664")?.cgColor
                self.uploadView.backgroundColor = UIColor(hexString: "0062FF")
            }
            UIView.transition(with: uploadImage,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                self.uploadImage.image = UIImage(named: "upload_document_plus", in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), with: .none)
            },
                              completion: nil)
        }
    }
}

private extension UploadDocumentCell {
    func addDashedBorder() {
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = 1.0
        dashBorder.strokeColor = UIColor(hexString: "B1BDC8")?.cgColor
        dashBorder.lineDashPattern = [4, 4]
        dashBorder.frame = contentView.bounds
        dashBorder.fillColor = nil
        dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        contentView.layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
