//
//  HomeNotificationsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.01.2023.
//

import UIKit
import GainyCommon

final class HomeNotificationsViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    var notifications: [ServerNotification] = []
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "HomeServerNotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HomeServerNotificationCollectionViewCell.reuseIdentifier)
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension HomeNotificationsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeServerNotificationCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeServerNotificationCollectionViewCell
        cell.notification = notifications[indexPath.row]
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        return cell
    }
}

extension HomeNotificationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainCoordinator?.showNotificationView(notifications[indexPath.row])
    }
}

extension HomeNotificationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width - 16.0 * 2.0,
              height: notifications[indexPath.row].height(for: UIScreen.main.bounds.width - 16.0 * 2.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
}
