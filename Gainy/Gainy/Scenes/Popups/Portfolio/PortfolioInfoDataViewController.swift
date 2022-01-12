//
//  PortfolioInfoDataViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/22/21.
//

import UIKit

protocol PortfolioInfoDataViewControllerDelegate: AnyObject {
    
    func didChangeInfoData(_ sender: AnyObject?, _ updatedDataSource: [InfoDataSource])
}

class PortfolioInfoDataViewController: BaseViewController {

    weak var delegate: PortfolioInfoDataViewControllerDelegate?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var selectAllSwitch: UISwitch!
    
    private var infoDataSource: [InfoDataSource] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setUpCollectionView()
        self.setUpNavigationBar()
        self.updateSelectAllSwitchState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if let dismissHandler = dismissHandler {
            dismissHandler()
            self.dismissHandler = nil
        }
    }
    
    public func configure(with infoDataSource:[InfoDataSource]) {
        
        self.infoDataSource = infoDataSource
        self.collectionView?.reloadData()
    }
    
    
    @IBAction func selectAllTouchUpInside(_ sender: UISwitch) {
        
        self.infoDataSource = self.infoDataSource.map({ item in
            InfoDataSource.init(type: item.type, id: item.id, title: item.title, iconURL: item.iconURL, selected: sender.isOn)
        })
        self.collectionView?.reloadData()
        self.delegate?.didChangeInfoData(self, self.infoDataSource)
    }
    
    private func updateSelectAllSwitchState() {
        
        let allSelected = self.infoDataSource.filter { item in
            item.selected
        }.count == self.infoDataSource.count
        self.selectAllSwitch.setOn(allSelected, animated: true)
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconClose")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        if let infoData = self.infoDataSource.first {
            if infoData.type == InfoDataSourceType.Interst {
                self.title = NSLocalizedString("Filter by Interests", comment: "Filter by  Interests").uppercased()
            } else if infoData.type == InfoDataSourceType.Category {
                self.title = NSLocalizedString("Filter by Investment categories", comment: "Filter by  Investment categories").uppercased()
            } else if infoData.type == InfoDataSourceType.SecurityType {
                self.title = NSLocalizedString("Filter by Security types", comment: "Filter by  Security types").uppercased()
            }
        }
    }
    
    private func setUpCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "InfoDataCell", bundle: Bundle.main), forCellWithReuseIdentifier: InfoDataCell.reuseIdentifier)
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true
        let layout = UICollectionViewCenterAlignedLayout()
        layout.sectionFootersPinToVisibleBounds = true
        self.collectionView.collectionViewLayout = layout
    }
    
    @objc private func backButtonTap(sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension PortfolioInfoDataViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let infoData = self.infoDataSource[indexPath.row]
        let cell: InfoDataCell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoDataCell.reuseIdentifier, for: indexPath) as! InfoDataCell
        cell.selectedColorHexString = "#5999FF"
        cell.infoData = infoData
        let isSelected = infoData.selected
        var canSelect = false
        var canDeselect = false
        if let indexPathsForSelectedItems = collectionView.indexPathsForSelectedItems {
            canSelect = !indexPathsForSelectedItems.contains(indexPath)
            canDeselect = indexPathsForSelectedItems.contains(indexPath)
        }
        
        if isSelected && canSelect {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            cell.isSelected = true
        } else if !isSelected && canDeselect{
            collectionView.deselectItem(at: indexPath, animated: false)
            cell.isSelected = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.infoDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let infoData = self.infoDataSource[indexPath.row]
        let name: String = infoData.title
        let width = name.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width
        var size = CGSize.init(width: (ceil(width) + CGFloat(56.0)), height: CGFloat(40))
        let maxWidth = UIScreen.main.bounds.size.width - 32.0
        if size.width > maxWidth {
            size.width = maxWidth
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(16.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(16.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 40.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let infoData = self.infoDataSource[indexPath.row]
        self.infoDataSource[indexPath.row] = InfoDataSource.init(type: infoData.type, id: infoData.id, title: infoData.title, iconURL: infoData.iconURL, selected: true)
        self.delegate?.didChangeInfoData(self, self.infoDataSource)
        self.updateSelectAllSwitchState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let infoData = self.infoDataSource[indexPath.row]
        self.infoDataSource[indexPath.row] = InfoDataSource.init(type: infoData.type, id: infoData.id, title: infoData.title, iconURL: infoData.iconURL, selected: false)
        self.delegate?.didChangeInfoData(self, self.infoDataSource)
        self.updateSelectAllSwitchState()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {

        return true
    }
}
