//
//  WebPresenter.swift
//  Gainy
//
//  Created by Anton Gubarenko on 09.12.2021.
//

import UIKit
import SafariServices

final class WebPresenter {
    
    class func openLink(vc: UIViewController, url: URL) {
        let svc = SFSafariViewController(url: url)
        if vc.presentedViewController == nil {
            vc.present(svc, animated: true, completion: nil)
        } else {
            vc.presentedViewController?.present(svc, animated: true, completion: nil)
        }
    }
    
}
