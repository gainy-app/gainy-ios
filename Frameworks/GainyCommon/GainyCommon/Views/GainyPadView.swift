//
//  GainyPadView.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import SnapKit

class GainyPadView: UIView {
    
    private let nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "•", "0", "←"]
    
    private var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        buttons.forEach({$0.removeFromSuperview()})
        buttons.removeAll()
        
        let w = bounds.width / 3.0
        let h = bounds.height / 4.0
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        for num in nums {
            let btn = makeBtn(num)
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
    
    private func makeBtn(_ title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .proDisplayRegular(32)
        btn.setTitleColor(.Gainy.mainText, for: .normal)
        return btn
    }
}
