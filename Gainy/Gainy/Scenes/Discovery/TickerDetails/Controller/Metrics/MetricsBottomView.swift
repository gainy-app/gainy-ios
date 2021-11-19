//
//  MetricsBottomView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/3/21.
//

import UIKit

protocol MetricsBottomViewDelegate: AnyObject {

    func metricsBottomViewDidTapSave(sender: Any)
}

final class MetricsBottomView: UIView {

    public weak var delegate: MetricsBottomViewDelegate?
    
    @IBOutlet private weak var saveButton: BorderButton!
    @IBOutlet private weak var textLabel: UILabel!
    
    public func setSaveButtonHidden(hidden: Bool) {
        
        UIView.animate(withDuration: 0.25) {
            
            self.saveButton?.alpha = hidden ? 0.0 : 1.0
            self.textLabel?.alpha = !hidden ? 0.0 : 1.0
        }
    }
    
    public func setText(text: String) {
        
        self.textLabel?.text = text
    }
    
    @IBAction private func onSaveButtonTap(_ sender: Any) {
        
        self.delegate?.metricsBottomViewDidTapSave(sender: self)
    }
}
