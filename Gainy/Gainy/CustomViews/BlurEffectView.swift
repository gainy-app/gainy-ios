//
//  BlurEffectView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.04.2022.
//

import UIKit

class BlurEffectView: UIVisualEffectView {
    
    var intensity: Double = 0.3
    
    init(intensity: Double = 0.3) {
        
        self.intensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        backgroundColor = .clear
        frame = superview.bounds //Or setup constraints instead
        setupBlur()
    }
    
    private func setupBlur() {
        animator.stopAnimation(true)
        effect = nil

        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .regular)
        }
        animator.fractionComplete = intensity   //This is your blur intensity in range 0 - 1
    }
    
    deinit {
        animator.stopAnimation(true)
    }
}
