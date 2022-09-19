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
    
    func setupView() {
        
        feedbackGenerator = UIImpactFeedbackGenerator()
        feedbackGenerator?.prepare()
        
        buttons.forEach({$0.removeFromSuperview()})
        buttons.removeAll()
        
        let w = bounds.width / 3.0
        let h = bounds.height / 4.0
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        for (ind, num) in nums.enumerated() {
            let btn = makeBtn(num, tag: ind)
            addSubview(btn)
            buttons.append(btn)
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(x)
                make.top.equalToSuperview().offset(y)
                make.width.equalTo(w)
                make.height.equalTo(h)
            }
            x += w
            if buttons.count % 3 == 0 {
                x = 0
                y += h + 8.0
            }
        }
    }
    
    private func makeBtn(_ title: String, tag: Int) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .proDisplayRegular(32)
        btn.setTitleColor(.Gainy.mainText, for: .normal)
        btn.tag = tag
        btn.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
        return btn
    }
    
     @objc private func tapBtn(_ btn: UIButton) {
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
