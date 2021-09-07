//
//  GainySliderView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit
import PureLayout

protocol GainySliderViewDelegate: AnyObject {
    
    func gainySliderFormattedValueString(sender: GainySliderView, currentValue: Float) -> String
    func gainySliderDidPickValue(sender: GainySliderView, currentValue: Float)
}

final class GainySliderView: UIView {
    
    public weak var delegate: GainySliderViewDelegate?
    
    private let slider: UISlider = CustomSlider.newAutoLayout()
    private let minLabel: UILabel = UILabel.newAutoLayout()
    private let maxLabel: UILabel = UILabel.newAutoLayout()
    private let valueLabel: UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        self.setUp()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.configureWith(currentValue: self.slider.value)
    }
    
    public func configureWith(currentValue: Float) {
        
        self.slider.value = currentValue
        self.updateUIWithCurrentValue(currentValue: currentValue)
    }
    
    public func configureWith(minLabelText: String, maxLabelText: String) {
        
        self.minLabel.text = minLabelText
        self.maxLabel.text = maxLabelText
    }
    
    private func updateUIWithCurrentValue(currentValue: Float) {
        
        self.valueLabel.text = self.delegate?.gainySliderFormattedValueString(sender: self, currentValue: currentValue)
        self.valueLabel.sizeToFit()
        self.valueLabel.center = self.adjustValueLabelPosition(slider: self.slider)
    }
    
    private func setUp() {
        
        self.backgroundColor = UIColor.clear
        self.setUpSlider()
        self.setUpMinLabel()
        self.setUpMaxLabel()
        self.setUpValueLabel()
    }
    
    private func setUpSlider() {
        
        self.addSubview(self.slider)
        self.slider.autoPinEdge(.leading, to: .leading, of: self)
        self.slider.autoPinEdge(.trailing, to: .trailing, of: self)
        self.slider.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -14.0)
        self.slider.autoSetDimension(.height, toSize: 24.0)
        self.slider.maximumTrackTintColor = UIColor.init(hexString: "#B1BDC8")
        self.slider.minimumTrackTintColor = UIColor.init(hexString: "#0261FF")
        self.slider.minimumValue = 0.0
        self.slider.maximumValue = 1.0
        self.slider.value = 0.5
        self.slider.isContinuous = true
        self.slider.setThumbImage(UIImage(named: "sliderThumb"), for: UIControl.State.normal)
        self.slider.addTarget(self, action: #selector(onSliderValueChanged(slider:event:)), for: .valueChanged)
    }
    
    private func setUpMinLabel() {
        
        self.addSubview(self.minLabel)
        self.minLabel.autoPinEdge(.leading, to: .leading, of: self)
        self.minLabel.autoPinEdge(.bottom, to: .bottom, of: self)
        self.minLabel.autoSetDimension(.height, toSize: 10.0)
        self.minLabel.font = UIFont.compactRoundedMedium(9.0)
        self.minLabel.textAlignment = .left
        self.minLabel.textColor = UIColor.init(hexString: "#687379")
        self.minLabel.text = "LESS"
    }
    
    private func setUpMaxLabel() {
        
        self.addSubview(self.maxLabel)
        self.maxLabel.autoPinEdge(.trailing, to: .trailing, of: self)
        self.maxLabel.autoPinEdge(.bottom, to: .bottom, of: self)
        self.maxLabel.autoSetDimension(.height, toSize: 10.0)
        self.maxLabel.font = UIFont.compactRoundedMedium(9.0)
        self.maxLabel.textAlignment = .right
        self.maxLabel.textColor = UIColor.init(hexString: "#687379")
        self.maxLabel.text = "MORE"
    }
    
    private func setUpValueLabel() {
        
        self.addSubview(self.valueLabel)
        self.valueLabel.font = UIFont.compactRoundedMedium(12.0)
        self.valueLabel.textAlignment = .center
        self.valueLabel.textColor = UIColor.black
    }
    
    @objc func onSliderValueChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                self.updateUIWithCurrentValue(currentValue: slider.value)
            case .moved:
                self.updateUIWithCurrentValue(currentValue: slider.value)
            case .ended:
                self.delegate?.gainySliderDidPickValue(sender: self, currentValue: slider.value)
            default:
                break
            }
        }
    }
    
    private func adjustValueLabelPosition(slider: UISlider) -> CGPoint {
        
        let sliderTrack = slider.trackRect(forBounds: slider.bounds)
        let sliderThumb = slider.thumbRect(forBounds: slider.bounds, trackRect: sliderTrack, value: slider.value)
        let textWidth = self.valueLabel.text?.sizeOfString(usingFont: self.valueLabel.font).width ?? 0.0
        var centerX = sliderThumb.origin.x + slider.frame.origin.x + 12
        let centerY = slider.frame.origin.y - 14.0
        let halfWidth = textWidth / 2.0
        if centerX <= halfWidth {
            centerX = halfWidth
        } else if centerX >= self.slider.frame.width - halfWidth {
            centerX = self.slider.frame.width - halfWidth
        }
        return CGPoint(x: centerX, y: centerY)
    }
}

final private class CustomSlider: UISlider {
   
       override func trackRect(forBounds bounds: CGRect) -> CGRect {
           var customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 2.0))
        customBounds.origin.y += 12.0
        customBounds.origin.x += 2.0
        customBounds.size.width -= 4.0
           super.trackRect(forBounds: customBounds)
           return customBounds
       }
}
