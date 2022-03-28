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
        if let rootViewController = UIApplication.shared.topMostViewController(),
           let topMostViewController = rootViewController.topMostViewController()  {
            topMostViewController.present(svc, animated: true, completion: nil)
        } else if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: { (_) in
            })
        } else {
            dprint("Failure when openLink: \(url)")
        }
    }
}
