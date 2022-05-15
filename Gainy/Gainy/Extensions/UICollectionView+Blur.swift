//
//  UICollectionView+Blur.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.05.2022.
//

import UIKit
import PureLayout

extension UICollectionReusableView {
    func addBlur() {
        guard subviews.first(where: {
            $0.tag == -11
        }) == nil else {return}
        let blurView = BlurEffectView()
        blurView.tag = -11
        addSubview(blurView)
        
        blurView.autoPinEdge(toSuperviewEdge: .leading)
        blurView.autoPinEdge(toSuperviewEdge: .top)
        blurView.autoPinEdge(toSuperviewEdge: .trailing)
        blurView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func removeBlur() {
        if let blurView = subviews.first(where: {
            $0.tag == -11
        }){
            blurView.removeFromSuperview()
        }
    }
}


