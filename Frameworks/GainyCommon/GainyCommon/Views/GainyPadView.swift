//
//  GainyPadView.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import SnapKit
import AudioToolbox
import LocalAuthentication

enum PadType: Equatable {
    case digit(_ value: Int)
    case dot
    case biometric
    case remove
    
    static func ==(lhs: PadType, rhs: PadType) -> Bool {
        switch (lhs, rhs) {
        case (.dot, .dot), (.biometric, .biometric), (.remove, .remove):
            return true
        case (.digit(let firstValue), .digit(let secondValue)):
            return firstValue == secondValue
        default:
            return false
        }
    }
}

public protocol GainyPadViewDelegate: AnyObject {
    func deleteDigit(view: GainyPadView)
    func addDigit(digit: String, view: GainyPadView)
    func didSuccessBiometry()
}

public extension GainyPadViewDelegate {
    func didSuccessBiometry() { }
}

@IBDesignable
public class GainyPadView: UIView {
    
    @IBInspectable public var isBiometric: Bool = false {
        didSet {
            if isBiometric {
                nums = [.digit(1), .digit(2), .digit(3), .digit(4), .digit(5), .digit(6), .digit(7), .digit(8), .digit(9), .biometric, .digit(0), .remove]
            } else {
                nums = [.digit(1), .digit(2), .digit(3), .digit(4), .digit(5), .digit(6), .digit(7), .digit(8), .digit(9), .dot, .digit(0), .remove]
            }
        }
    }
    
    private var context = LAContext()
    
    public weak var delegate: GainyPadViewDelegate?
    public var hideDot = false
    
    private var nums: [PadType] = [.digit(1), .digit(2), .digit(3), .digit(4), .digit(5), .digit(6), .digit(7), .digit(8), .digit(9), .dot, .digit(0), .remove] {
        didSet {
            setupView()
        }
    }
    private var buttons: [UIButton] = []
    
    open private(set) var feedbackGenerator: UIImpactFeedbackGenerator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let wOffset = 6.0
        let hOffset = 7.0
        let w = (bounds.width - wOffset * 2.0) / 3.0 
        let h = (bounds.height - hOffset * 3.0) / 4.0
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        for (ind, num) in nums.enumerated() {
            if hideDot && num == .dot {
                x += (w + wOffset)
                if (ind + 1) % 3 == 0 {
                    x = 0.0
                    y += (h + hOffset)
                }
                continue
            }
            let btn = buttons[ind]
            btn.snp.removeConstraints()
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(x)
                make.top.equalToSuperview().offset(y)
                make.width.equalTo(w)
                make.height.equalTo(h)
            }
            x += (w + wOffset)
            if (ind + 1) % 3 == 0 {
                x = 0.0
                y += (h + hOffset)
            }
        }
    }
    
    func setupView() {
        
        feedbackGenerator = UIImpactFeedbackGenerator()
        feedbackGenerator?.prepare()
        buttons.forEach({$0.removeFromSuperview()})
        buttons.removeAll()
        for (ind, num) in nums.enumerated() {
            let btn = makeBtn(num, tag: ind)
            buttons.append(btn)
            if hideDot && num == .dot { continue }
            addSubview(btn)
        }
    }
    
    private func makeBtn(_ type: PadType, tag: Int) -> UIButton {
        let btn = UIButton()
        btn.titleLabel?.font = .proDisplayRegular(32)
        btn.setTitleColor(.Gainy.mainText, for: .normal)
        if isBiometric {
            btn.backgroundColor = .clear
        } else {
            btn.backgroundColor = .white
        }
        btn.layer.cornerRadius = 0.0
        btn.layer.shadowColor = (UIColor(hexString: "#898A8D") ?? .Gainy.darkGray).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 0.0
        btn.tag = tag
        btn.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
        switch type {
        case .digit(let digit):
            btn.setTitle("\(digit)", for: .normal)
        case .dot:
            btn.setTitle("•", for: .normal)
        case .biometric:
            switch context.biometryType {
            case .touchID:
                btn.setImage(UIImage(systemName: "touchid")?.withTintColor(.black), for: .normal)
            default:
                btn.setImage(UIImage(systemName: "faceid")?.withTintColor(.black), for: .normal)
            }
        case .remove:
            btn.setTitle("←", for: .normal)
        }
        return btn
    }
    
     @objc private func tapBtn(_ btn: UIButton) {
         btn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
         UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
             btn.transform = CGAffineTransform.identity
         }, completion: nil)
         
         feedbackGenerator?.impactOccurred()
         AudioServicesPlaySystemSound(0x450)

         guard let num = nums[safe: btn.tag] else { return }
         switch num {
         case .digit(let value):
             delegate?.addDigit(digit: "\(value)", view: self)
         case .dot:
             delegate?.addDigit(digit: ".", view: self)
             return
         case .biometric:
             let reason = "Log in with Face ID"
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak delegate] success, error in
                 if success {
                     delegate?.didSuccessBiometry()
                 }
             }
         case .remove:
             delegate?.deleteDigit(view: self)
             return
         }
    }
}
