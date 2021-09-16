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
    
    public func setNextButtonHidden(hidden: Bool) {
        
        UIView.animate(withDuration: 0.25) {
            
            self.nextButton?.alpha = hidden ? 0.0 : 1.0
            self.textLabel?.alpha = !hidden ? 0.0 : 1.0
        }
    }
    
    @IBAction private func onNextButtonTap(_ sender: Any) {
        
        self.delegate?.personalizationPickInterestsFooterDidTapNext(sender: self)
    }
}
