//
//  UICollectionView+Blur.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.05.2022.
//

import UIKit
import PureLayout

extension UIView {
    func addBlur() {
        guard subviews.first(where: {
            $0.tag == -11
        }) == nil else {return}
        let blurView = BlurEffectView(intensity: 0.2)
        blurView.tag = -11
        addSubview(blurView)
        
        blurView.autoPinEdge(toSuperviewEdge: .leading, withInset: -10)
        blurView.autoPinEdge(toSuperviewEdge: .top, withInset: -10)
        blurView.autoPinEdge(toSuperviewEdge: .trailing, withInset: -10)
        blurView.autoPinEdge(toSuperviewEdge: .bottom, withInset:-10)
    }
    
    func removeBlur() {
        if let blurView = subviews.first(where: {
            $0.tag == -11
        }){
            blurView.removeFromSuperview()
        }
    }
    
    func addBlockView() {
        guard subviews.first(where: {
            $0.tag == -12
        }) == nil else {return}
        let blockView = TTFBlockView()
        blockView.tag = -12
        addSubview(blockView)
        
        blockView.autoPinEdge(toSuperviewEdge: .leading)
        blockView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        blockView.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    func removeBlockView() {
        if let blockView = subviews.first(where: {
            $0.tag == -12
        }){
            blockView.removeFromSuperview()
        }
    }
}


