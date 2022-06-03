//
//  DetectableCollectionView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.05.2022.
//

import UIKit
import Foundation

final class DetectableCollectionView: UICollectionView {
    
  
    weak var headerView: TTFBlockView?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let button = headerView?.unlockBtn else {return true}
        var btnFrame = button.convert(button.bounds, from: self)
        btnFrame.origin = CGPoint.init(x: btnFrame.origin.x  * -1, y: btnFrame.origin.y * -1)
        if btnFrame.contains(point) {
            
            NSObject.cancelPreviousPerformRequests(
                       withTarget: self,
                       selector: #selector(triggerTap),
                       object: nil
                   )
                   perform(#selector(triggerTap), with: nil, afterDelay: 0.5)
        }
        return true
    }
    
    @objc private func triggerTap() {
        headerView?.unlockAction()
    }
}
