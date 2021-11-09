//
//  BrokerViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.08.2021.
//

import UIKit

final class BrokerViewCell: UICollectionViewCell {

    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var brokerImage: UIImageView!
    @IBOutlet private weak var selectedImage: UIImageView!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateUI()
    }
    
    var brokerData: BrokerData? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let brokerData = brokerData, let brokerImage = brokerImage, let borderView = borderView, let selectedImage = selectedImage  else {
            return
        }
        
        brokerImage.image = UIImage.init(named: brokerData.imageName)
        var selected = false
        if let selectedBroker = UserProfileManager.shared.selectedBrokerToTrade, selectedBroker == brokerData {
            selected = true
        }
        
        selectedImage.isHidden = !selected
        
        borderView.layer.borderWidth = 2.0
        borderView.layer.cornerRadius = 20.0
        
        let color = selected ? UIColor.init(hex: 0x09141F) : UIColor.init(hex: 0xE7EAEE)
        borderView.layer.borderColor = color?.cgColor
        self.alpha = self.isHighlighted ? 0.75 : 1.0
    }
}
