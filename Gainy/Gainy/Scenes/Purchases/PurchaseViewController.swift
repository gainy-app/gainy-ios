//
//  PurchaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.05.2022.
//

import UIKit
import Foundation
import AVFoundation

final class PurchaseViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    //MARK: - Outlets
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern(kern: 1.25, color: .white)
        }
    }
    
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
        avPlayerLayer.isHidden = false
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
        avPlayerLayer.isHidden = true
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
    }
    
    
//MARK: - Actions
    
    @IBAction private func closeAction() {
        dismiss(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
