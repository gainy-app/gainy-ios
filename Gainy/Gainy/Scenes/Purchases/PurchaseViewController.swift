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
    @IBOutlet private weak var spacemanView: UIImageView!
    @IBOutlet private weak var extraCover: UIImageView!
    @IBOutlet private weak var orbitView: UIImageView!
    @IBOutlet private weak var purchasesView: PurchasesProductsView!
    @IBOutlet private weak var purchasesScroll: UIScrollView! {
        didSet {
            purchasesScroll.delegate = self
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var inviteView: PurchaseInviteView!
    
    private var isInvite: Bool = false {
        didSet {
            UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveLinear, .beginFromCurrentState]) {
                self.spacemanView.transform = .init(scaleX: self.isInvite ? 0.83 : 1.0, y: self.isInvite ? 0.83 : 1.0)
                self.extraCover.alpha = self.isInvite ? 1.0 : 0.0
                self.orbitView.transform = .init(scaleX: self.isInvite ? 1.0 : 0.7, y: self.isInvite ? 1.0 : 0.7)
            } completion: { done in
                if done {
                    
                }
            }

        }
    }
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern(kern: 1.25, color: .white)
        }
    }
    
    @IBOutlet private weak var purchaseBtn: UIButton! {
        didSet {
            purchaseBtn.layer.cornerRadius = 20
        
            let backGradientView = GradientPlainBackgroundView()
            backGradientView.startColor = UIColor(hexString: "1B44F7")
            backGradientView.endColor = UIColor(hexString: "357CFD")
            backGradientView.startPoint = .init(x: 0, y: 0.5)
            backGradientView.endPoint = .init(x: 1, y: 0.5)
            purchaseBtn.addSubview(backGradientView)
            backGradientView.autoPinEdgesToSuperviewEdges()
            
            purchaseBtn.backgroundColor = UIColor(hexString: "#1B45FB")!
            purchaseBtn.layer.shadowColor = UIColor(hexString: "4484FF")!.cgColor
            purchaseBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
            purchaseBtn.layer.shadowRadius = 24
            purchaseBtn.layer.shadowOpacity = 0.64
            purchaseBtn.layer.cornerRadius = 20.0
            purchaseBtn.clipsToBounds = true
            purchaseBtn.isUserInteractionEnabled = true
            
            purchaseBtn.addTarget(self, action: #selector(purchaseAction), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        self.setupPlayer()
        self.orbitView.transform = .init(scaleX: self.isInvite ? 1.0 : 0.7, y: self.isInvite ? 1.0 : 0.7)
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
    
    @objc func purchaseAction() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PurchaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > (UIScreen.main.bounds.width - 48) {
            inviteView.isSelected = true
            purchaseBtn.setTitle("Share link".uppercased(), for: .normal)
            self.isInvite = true
            pageControl.currentPage = 2
        } else {
            inviteView.isSelected = false
            purchaseBtn.setTitle("Continue".uppercased(), for: .normal)
            self.isInvite = false
            pageControl.currentPage = 1
        }
    }
}
