//
//  ConfigLoaderViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.04.2022.
//

import UIKit
import FirebaseRemoteConfig
import OneSignal
import AVFoundation

final class ConfigLoaderViewController: BaseViewController {
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    @IBOutlet private weak var logoImgView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var starsView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading()
    }
    
    func startLoading() {
        setupPlayer()
        avPlayer.play()
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear) {
            self.logoImgView.alpha = 0
            self.starsView.alpha = 0
            self.containerView.alpha = 1
        } completion: { done in
            if done {
                self.showNetworkLoader()
                RemoteConfigManager.shared.loadDefaults {
                    runOnMain {

                        OneSignal.promptForPushNotifications(userResponse: { accepted in
                            print("User accepted notification: \(accepted)")
                            GainyAnalytics.logEvent("pushes_status", params: ["accepted" : accepted])
                        })
//                            self.view.removeFromSuperview()
//                            self.avPlayer.pause()
//                            self.paused = true
                    }
                }
            }
        }
        
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Space", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        containerView.layer.insertSublayer(avPlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
}
