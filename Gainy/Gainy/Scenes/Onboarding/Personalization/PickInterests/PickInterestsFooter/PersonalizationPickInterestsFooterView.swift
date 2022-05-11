//
//  PersonalizationPickInterestsFooterView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/3/21.
//

import UIKit

protocol PersonalizationPickInterestsFooterViewDelegate: AnyObject {

    func personalizationPickInterestsFooterDidTapNext(sender: Any)
}

final class PersonalizationPickInterestsFooterView: UIView {

    public weak var delegate: PersonalizationPickInterestsFooterViewDelegate?
    
    @IBOutlet private weak var nextButton: BorderButton!
    @IBOutlet private weak var textLabel: UILabel!
    
    public func setNextButtonActive(active: Bool) {
        
        self.nextButton.isHidden = false
        self.nextButton?.alpha = 1.0
        self.textLabel?.alpha = active ? 0.0 : 1.0
        self.nextButton.layer.borderColor = UIColor.clear.cgColor
        self.nextButton.backgroundColor = !active ? UIColor.init(hexString: "#B1BDC8"): UIColor.black
    }
    
    @IBAction private func onNextButtonTap(_ sender: Any) {
        
        self.delegate?.personalizationPickInterestsFooterDidTapNext(sender: self)
    }
}
