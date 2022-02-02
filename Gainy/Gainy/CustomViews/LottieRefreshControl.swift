//
//  LottieRefreshControl.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.01.2022.
//

import UIKit
import Lottie

final class LottieRefreshControl: UIRefreshControl {
    fileprivate let animationView = Lottie.AnimationView(animation: Animation.named("loader3"))
    fileprivate var isAnimating = false
    
    fileprivate let maxPullDistance: CGFloat = 32.0 * 3.0
    
    override init() {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress(with offsetY: CGFloat) {
        runOnMain {
            guard !isAnimating else { return }
            let progress = min(abs(offsetY / maxPullDistance), 1)
            animationView.currentProgress = progress
        }
    }
    
    override func beginRefreshing() {
        runOnMain {
            super.beginRefreshing()
            isAnimating = true
            animationView.currentProgress = 0
            animationView.play()
        }
    }
    
    override func endRefreshing() {
        runOnMain {
            super.endRefreshing()
            animationView.stop()
            isAnimating = false
        }
    }
}

private extension LottieRefreshControl {
    func setupView() {
        runOnMain {
            // hide default indicator view
            tintColor = .clear
            animationView.loopMode = .loop
            addSubview(animationView)
            
            addTarget(self, action: #selector(beginRefreshing), for: .valueChanged)
        }
    }
    
    func setupLayout() {
        runOnMain {
            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
                animationView.widthAnchor.constraint(equalToConstant: 32),
                animationView.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
    }
}
