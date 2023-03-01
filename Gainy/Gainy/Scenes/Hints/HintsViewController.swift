//
//  HintsViewController.swift
//  Gainy
//
//  Created by r10 on 06.02.2023.
//

import UIKit
import GainyCommon
import AVFoundation

struct HintCellModel {
    let title: String
    var subtitle: String?
    var coverImage: UIImage?
    var mainImage: UIImage?
}
 

class HintsViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    // MARK: - Private properties
    var cellModels: [HintCellModel] = []
    
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: GainyPageControl!
    @IBOutlet private weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 16
        }
    }
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    private var stepTimer: Timer?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        startLoading()
        delay(0.3) {
            self.collectionView.reloadData()
            self.startTimer()
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapNext(_ sender: UIButton) {
        guard let visibleCells = collectionView.indexPathsForVisibleItems.first else { return }
        if visibleCells.row != (cellModels.count - 1) {
            collectionView.scrollToItem(at: .init(row: visibleCells.row + 1, section: visibleCells.section), at: .left, animated: true)
        } else {
            if let nav = navigationController {
                nav.popViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        }
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismissHandler?()
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    //MARK: - Player
    
    func startLoading() {
        setupPlayer()
        avPlayer.play()
    }
    
    func stopLoading() {
        avPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Space", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        self.view.layer.insertSublayer(avPlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
    
    //MARK: - Timer
    
    private func startTimer() {
        stopTimer()
        stepTimer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true, block: {[weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            if self.pageControl.currentPage < self.cellModels.count {
                DispatchQueue.main.async {
                    self.collectionView.setContentOffset(.init(x: CGFloat(self.pageControl.currentPage + 1) * UIScreen.main.bounds.width, y: 0), animated: true)
                }
            } else {
                self.stopTimer()
                self.nextButton.setTitle("Done", for: .normal)
            }
        })
        stepTimer?.tolerance = 0.5
        if let stepTimer {
            RunLoop.current.add(stepTimer, forMode: .common)
        }
    }
    
    private func stopTimer() {
        stepTimer?.invalidate()
        stepTimer = nil
    }
}

// MARK: - UICollectionViewDataSource
extension HintsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cellModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.reuseIdentifier, for: indexPath) as? HintCell else { return UICollectionViewCell() }
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (cellModels.count - 1) {
            nextButton.setTitle("Done", for: .normal)
            stopTimer()
        } else {
            nextButton.setTitle("Next", for: .normal)
            startTimer()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HintsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: UIScreen.main.bounds.width,
                           height: collectionView.bounds.height)
        print(size)
        return size
    }
}
private extension HintsViewController {
    func configure() {
        collectionView.register(HintCell.nib, forCellWithReuseIdentifier: HintCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        pageControl.numberOfPages = cellModels.count
        pageControl.currentPage = 0
    }
}

extension HintsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
