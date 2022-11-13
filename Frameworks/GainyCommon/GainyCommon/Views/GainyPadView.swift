//
//  GainyPadView.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import SnapKit
import AudioToolbox

public protocol GainyPadViewDelegate: AnyObject {
    func deleteDigit(view: GainyPadView)
    func addDigit(digit: String, view: GainyPadView)
}

public class GainyPadView: UIView {
    
    public weak var delegate: GainyPadViewDelegate?
    public var hideDot = false
    
    private let nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "•", "0", "←"]
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
            if hideDot && num == "•" {
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
            if hideDot && num == "•" {continue}
            addSubview(btn)
        }
    }
    
    private func makeBtn(_ title: String, tag: Int) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .proDisplayRegular(32)
        btn.setTitleColor(.Gainy.mainText, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 0.0
        btn.layer.shadowColor = (UIColor(hexString: "#898A8D") ?? .Gainy.darkGray).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 0.0
        btn.tag = tag
        btn.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
        return btn
    }
    
     @objc private func tapBtn(_ btn: UIButton) {
         
         btn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
         UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
             btn.transform = CGAffineTransform.identity
         }, completion: nil)
         
         feedbackGenerator?.impactOccurred()
         AudioServicesPlaySystemSound(0x450)
         
         let tag = btn.tag
         
         if tag == nums.count - 1 {
             delegate?.deleteDigit(view: self)
             return
         }
         if nums[tag] == "•" {
             delegate?.addDigit(digit: ".", view: self)
             return
         }
         delegate?.addDigit(digit: nums[tag], view: self)
    }
}
