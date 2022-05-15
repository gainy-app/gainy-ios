//
//  IDFARequestViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.01.2022.
//

import UIKit
import AppTrackingTransparency
import AdSupport
import AVFoundation
import Apollo

protocol IDFARequestViewControllerDelegate: AnyObject {
    
    func didChooseResponse()
}

final class IDFARequestViewController: UIViewController, Storyboarded {
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    var delegate: IDFARequestViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        self.setupPlayer()
        
        avPlayer.play()
        paused = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Gradient_Stars", withExtension: "mp4")

        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
    }
    
    //MARK: - Actions
    
    @IBAction func requestIDFAAction() {
        requestTrackingAuthorization()
    }
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14, *) else {
            self.dismiss(animated: true) {
                self.delegate?.didChooseResponse()
            }
            return
        }
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    dprint("Got IDFA")
                    print(self.identifierForAdvertising())
                case .denied, .restricted:
                    dprint("Denied IDFA")
                case .notDetermined:
                    dprint("Not Determined IDFA")
                @unknown default:
                    break
                }
                self.dismiss(animated: true) {
                    self.delegate?.didChooseResponse()
                }
            }
        }
    }
    
    private func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
