//
//  LaunchScreenViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/27/21.
//

import UIKit
import AVFoundation

class LaunchScreenViewController: BaseViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var authorizationManager: AuthorizationManager?
    weak var coordinator: OnboardingCoordinator?
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    @UserDefaultBool("isIDFAShown")
    private var isIDFAShown: Bool
    
    private func showIDFAIfNeeded() {
        guard !isIDFAShown else {return}
        let idfaVC = IDFARequestViewController.instantiate(.popups)
        idfaVC.modalPresentationStyle = .fullScreen
        present(idfaVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.setupPlayer()
        
        avPlayer.play()
        paused = false
        
        delay(1.0) {
            self.showIDFAIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero)
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"intro", withExtension: "mp4")

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
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func signInTouchUpInside(_ sender: Any) {
        
        GainyAnalytics.logEvent("sign_in_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "LaunchScreen"])
        self.coordinator?.presentAuthorizationViewController()
    }
    
    @IBAction func getStartedTouchUpInside(_ sender: Any) {
        
        self.authorizationManager?.resetStatus()
        GainyAnalytics.logEvent("get_started_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "LaunchScreen"])
        self.coordinator?.pushIntroductionViewController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
