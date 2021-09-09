//
//  ResponsiveButton.swift
//  Gainy
//
//  Created by Anton Gubarenko on 09.09.2021.
//

import UIKit

class ResponsiveButton: UIButton {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    
    @objc private func touchDown() {
    }
    
    @objc private func touchUp() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: nil)

    }
}
