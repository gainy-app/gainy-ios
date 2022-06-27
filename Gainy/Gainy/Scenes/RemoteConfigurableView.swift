//
//  RemoteConfigurableView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 27.06.2022.
//

import UIKit

protocol RemoteConfigurable: AnyObject {
    var mainBackColor: UIColor {get}
    var mainButtonColor: UIColor {get}
    func fillRemoteBack()
    func fillRemoteButtonBack()
}

extension UIView: RemoteConfigurable {
    var mainBackColor: UIColor {
        RemoteConfigManager.shared.mainBackColor
    }
    
    var mainButtonColor: UIColor {
        RemoteConfigManager.shared.mainButtonColor
    }
    
    func fillRemoteBack() {
        backgroundColor = mainBackColor
    }
    
    func fillRemoteButtonBack() {
        backgroundColor = mainButtonColor
    }
}
