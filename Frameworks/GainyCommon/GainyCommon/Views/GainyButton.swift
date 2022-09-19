//
//  GainyButton.swift
//  GainyCommon
//
//  Created by Serhii Borysov on 9/13/22.
//

import UIKit

public class GainyButton: UIButton {
       
    open var buttonActionHandler: ((UIButton) -> ())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func configureWithCornerRadius(radius: Float) {
        
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = false
    }
    
    public func configureWithBorder(borderWidth: Float, borderColor: UIColor) {
        
        layer.borderWidth = CGFloat(borderWidth)
        layer.borderColor = borderColor.cgColor
    }
    
    public func configureWithBackgroundColor(color: UIColor) {
        
        self.bgColor = color
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    public func configureWithDisabledBackgroundColor(color: UIColor) {
        
        self.bgColorDisabled = color
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    public func configureWithHighligtedBackgroundColor(color: UIColor) {
        
        self.bgColorDisabled = color
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    public func configureWithTitle(title: String, color: UIColor, state: UIControl.State) {
        
        self.setTitleColor(color, for: state)
        self.setTitle(title, for: state)
    }
    
    public func configureWithFont(font: UIFont) {
        
        self.titleLabel?.font = font
    }
    
    private var bgColor: UIColor = UIColor.init(hexString: "#0062FF") ?? UIColor.blue
    private var bgColorDisabled: UIColor = UIColor.init(hexString: "#E7EAEE") ?? UIColor.lightGray
    private var bgColorHighlighted: UIColor = UIColor.init(hexString: "#0062FF") ?? UIColor.blue.withAlphaComponent(0.5)
    
    public override var isHighlighted: Bool {
        
        didSet {
            self.backgroundColor = isHighlighted ? self.bgColorHighlighted : self.bgColor
        }
    }
    
    public override var isEnabled: Bool {
        
        didSet {
            self.backgroundColor = !isEnabled ? self.bgColorDisabled : self.bgColor
        }
    }
    
    private func setupView() {
        
        self.configureWithTitle(title: "Button Normal", color: UIColor.white, state: .normal)
        self.configureWithTitle(title: "Button Disabled", color: UIColor.white, state: .disabled)
        //self.configureWithTitle(title: "Button Highlighted", color: UIColor.white, state: .highlighted)
        self.configureWithFont(font: UIFont.proDisplayMedium(16.0))
        self.configureWithCornerRadius(radius: 16.0)
        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
        addTarget(self, action: #selector(touchUpInside), for: [.touchUpInside,])
    }
    
    
    @objc private func touchDown() {
        
    }
    
    @objc private func touchUp() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc private func touchUpInside() {
        
        self.buttonActionHandler?(self)
    }
}

