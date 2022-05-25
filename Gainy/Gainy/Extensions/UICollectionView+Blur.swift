//
//  UICollectionView+Blur.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.05.2022.
//

import UIKit
import PureLayout

extension UIView {
    func addBlur(top: CGFloat = -8, bottom: CGFloat = -8, left: CGFloat = -8, right: CGFloat = -8) {
        let blurAdded = subviews.first(where: {
            $0.tag == -11
        })
        
        guard blurAdded == nil else {
            (blurAdded as? BlurEffectView)?.intensity = 0.2
            return
        }
        
        let blurView = BlurEffectView(intensity: 0.2)
        blurView.tag = -11
        addSubview(blurView)
        
        let whiteBack = UIView()
        whiteBack.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        whiteBack.tag = -14
        addSubview(whiteBack)
        
        blurView.autoPinEdge(toSuperviewEdge: .leading, withInset: left)
        blurView.autoPinEdge(toSuperviewEdge: .top, withInset: top)
        blurView.autoPinEdge(toSuperviewEdge: .trailing, withInset: right)
        blurView.autoPinEdge(toSuperviewEdge: .bottom, withInset: bottom)
        
        whiteBack.autoPinEdge(toSuperviewEdge: .leading, withInset: left)
        whiteBack.autoPinEdge(toSuperviewEdge: .top, withInset: top)
        whiteBack.autoPinEdge(toSuperviewEdge: .trailing, withInset: right)
        whiteBack.autoPinEdge(toSuperviewEdge: .bottom, withInset: bottom)
    }
    
    func removeBlur() {
        if let blurView = subviews.first(where: {
            $0.tag == -11
        }){
            blurView.removeFromSuperview()
        }
        if let blurView = subviews.first(where: {
            $0.tag == -14
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
        
        blockView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        blockView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        blockView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
    }
    
    func removeBlockView() {
        if let blockView = subviews.first(where: {
            $0.tag == -12
        }){
            blockView.removeFromSuperview()
        }
    }
}


