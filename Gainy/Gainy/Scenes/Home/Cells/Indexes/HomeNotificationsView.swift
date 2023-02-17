//
//  HomeNotificationsView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.01.2023.
//

import UIKit
import SnapKit
import GainyCommon
import Combine

final class HomeNotificationsView: UIView {
    
    var tapCallback: (() -> Void)? = nil
    
    lazy var pageControl: GainyPageControl = {
        let pageControl = GainyPageControl.init(frame: CGRect.init(x: 24, y: 0, width: 200, height: 24), numberOfPages: ServerNotificationsManager.shared.serverNotifications.count)
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hideForSinglePage = true
        return pageControl
    }()
    
    lazy var circleView: CornerView = create { corner in
        corner.cornerRadius = 32.0 / 2.0
        corner.backgroundColor = UIColor(hexString: "#FC5058")!
        corner.clipsToBounds = true
    }
    
    lazy var badgeLbl: UILabel = create { lbl in
        lbl.textColor = .white
        lbl.font = .compactRoundedSemibold(14)
        lbl.text = ""
        lbl.textAlignment = .center
    }
    
    var notifications: [ServerNotification] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.isHidden = notifications.count < 2
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "HomeServerNotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HomeServerNotificationCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    
    private func setupView() {
        layer.cornerRadius = 16.0
        backgroundColor = .white
        clipsToBounds = true
        
        ServerNotificationsManager.shared.unreadCountPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] unreadCount in
                self?.badgeLbl.text = unreadCount == 0 ? nil : "\(unreadCount)"
                self?.circleView.isHidden = unreadCount == 0
            }
            .store(in: &cancellables)
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
        }
        
        let unreadCount = ServerNotificationsManager.shared.unreadCount
        badgeLbl.text = unreadCount == 0 ? nil : "\(unreadCount)"
        circleView.isHidden = unreadCount == 0
        circleView.addSubview(badgeLbl)
        badgeLbl.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}


extension HomeNotificationsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeServerNotificationCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeServerNotificationCollectionViewCell
        cell.notification = notifications[indexPath.row]
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        cell.hideText = true
        return cell
    }
}

extension HomeNotificationsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapCallback?()
    }
}

extension HomeNotificationsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width - 16.0 * 2.0, height: 144.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension HomeNotificationsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        readCurrentNotif()
    }
    
    func readCurrentNotif() {
        guard notifications.count > pageControl.currentPage else {return}
        var notification = notifications[pageControl.currentPage]
        if !ServerNotificationsManager.shared.isNotifViewed(notification) {
            Task {
                await ServerNotificationsManager.shared.viewNotifications(notifications: [notification])
            }
        }
    }
}
