//
//  BorderButton.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.08.2021.
//
import UIKit

@IBDesignable
class BorderButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor(named: "mainText")! {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1.0
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
