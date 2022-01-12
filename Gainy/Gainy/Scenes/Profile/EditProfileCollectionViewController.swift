//
//  EditAppInterestsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit

enum ProfileCollectionType {
    case AppInterests
    case AppCategories
}

protocol EditProfileCollectionViewControllerDelegate: AnyObject {
    
    func didSelectInterest(_ sender: EditProfileCollectionViewController?, _ interest: AppInterestsQuery.Data.Interest)
    func didDeselectInterest(_ sender: EditProfileCollectionViewController?, _ interest: AppInterestsQuery.Data.Interest)
    func didSelectCategory(_ sender: EditProfileCollectionViewController?, _ category: CategoriesQuery.Data.Category)
    func didDeselectCategory(_ sender: EditProfileCollectionViewController?, _ category: CategoriesQuery.Data.Category)
    
    func showDisclaimer(_ sender: EditProfileCollectionViewController?)
    func didChangeSettings(_ sender: EditProfileCollectionViewController?)
    func shouldShowDisclaimer(_ sender: EditProfileCollectionViewController?) -> Bool
}

final class EditProfileCollectionViewController: BaseViewController {
    
    weak var delegate: EditProfileCollectionViewControllerDelegate?
    weak var coordinator: MainCoordinator?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var collectionType: ProfileCollectionType?
    private var interestsSelected: [AppInterestsQuery.Data.Interest]?
    private var interests: [AppInterestsQuery.Data.Interest]?
    private var categoriesSelected: [CategoriesQuery.Data.Category]?
    private var categories: [CategoriesQuery.Data.Category]?
    
    private var currentIndexPath: IndexPath?
    private var select: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setUpCollectionView()
        self.setUpNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if let dismissHandler = dismissHandler {
            dismissHandler()
            self.dismissHandler = nil
        }
    }
    
    public func configure(with interests:[AppInterestsQuery.Data.Interest], interestsSelected selected:[AppInterestsQuery.Data.Interest]) {
        
        self.collectionType = ProfileCollectionType.AppInterests
        self.interests = interests
        self.interestsSelected = selected
        self.collectionView?.reloadData()
    }
    
    public func configure(with categories:[CategoriesQuery.Data.Category], categoriesSelected selected:[CategoriesQuery.Data.Category]) {
        
        self.collectionType = ProfileCollectionType.AppCategories
        self.categories = categories
        self.categoriesSelected = selected
        self.collectionView?.reloadData()
    }
    
    public func proceedEditing() {
        
        guard let indexPath = self.currentIndexPath else { return }
        
        self.delegate?.didChangeSettings(self)
        
        if self.select {
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            self.collectionView(self.collectionView, didSelectItemAt: indexPath)
        } else {
            self.collectionView.deselectItem(at: indexPath, animated: false)
            self.collectionView(self.collectionView, didDeselectItemAt: indexPath)
        }
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
        if let collectionType = self.collectionType {
            if collectionType == .AppInterests {
                self.title = NSLocalizedString("Interests", comment: "Interests").uppercased()
            } else if collectionType == .AppCategories {
                self.title = NSLocalizedString("Investment categories", comment: "Investment categories").uppercased()
            }
        }
    }
    
    private func setUpCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "PickInterestOrCategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier)
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

extension EditProfileCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let collectionType = self.collectionType else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
        }
        let cell: PickInterestOrCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier, for: indexPath) as! PickInterestOrCategoryCell
        cell.selectedColorHexString = "#5999FF"
        var isSelected: Bool = false
        if collectionType == .AppInterests {
            let profileInterest: AppInterestsQuery.Data.Interest? = self.interests?[indexPath.row]
            cell.appInterest = profileInterest
            
            if let selected = (interestsSelected?.contains(where: {$0.id == profileInterest!.id })) {
                isSelected = selected
            }
        } else if collectionType == .AppCategories {
            let profileCategory: CategoriesQuery.Data.Category? = self.categories?[indexPath.row]
            cell.appCategory = profileCategory
            if let selected = (categoriesSelected?.contains(where: {$0.id == profileCategory!.id })) {
                isSelected = selected
            }
        }
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
        
        guard let collectionType = self.collectionType else {
            return 0
        }
        
        if collectionType == .AppInterests {
            return self.interests?.count ?? 0
        } else if collectionType == .AppCategories {
            return self.categories?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let collectionType = self.collectionType else {
            return CGSize.zero
        }
        
        var name: String? = nil
        if collectionType == .AppInterests {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.interests?[indexPath.row] else {
                return CGSize.zero
            }
            name = profileInterest.name
        } else if collectionType == .AppCategories {
            guard let profileCategory: CategoriesQuery.Data.Category = self.categories?[indexPath.row] else {
                return CGSize.zero
            }
            name = profileCategory.name
        }
        guard let name = name else {
            return CGSize.zero
        }
        
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
        
        guard let collectionType = self.collectionType else {
            return
        }
        if collectionType == .AppInterests {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.interests?[indexPath.row] else {
                return
            }
            self.interestsSelected?.append(profileInterest)
            self.delegate?.didSelectInterest(self, profileInterest)
        } else if collectionType == .AppCategories {
            guard let profileCategory: CategoriesQuery.Data.Category = self.categories?[indexPath.row] else {
                return
            }
            self.categoriesSelected?.append(profileCategory)
            self.delegate?.didSelectCategory(self, profileCategory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let collectionType = self.collectionType else {
            return
        }
        if collectionType == .AppInterests {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.interests?[indexPath.row] else {
                return
            }
            let index = self.interestsSelected?.lastIndex(where: { interest in
                interest.id == profileInterest.id
            })
            if index != nil {
                if let removedInterest = self.interestsSelected?.remove(at: index!) {
                    self.delegate?.didDeselectInterest(self, removedInterest)
                }
            }
        } else if collectionType == .AppCategories {
            guard let profileCategory: CategoriesQuery.Data.Category = self.categories?[indexPath.row] else {
                return
            }
            let index = self.categoriesSelected?.lastIndex(where: { category in
                category.id == profileCategory.id
            })
            if index != nil {
                if let removedCategory = self.categoriesSelected?.remove(at: index!) {
                    self.delegate?.didDeselectCategory(self, removedCategory)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard let collectionType = self.collectionType else {
            return false
        }
        
        if delegate?.shouldShowDisclaimer(self) ?? false {
            
            self.currentIndexPath = indexPath
            self.select = true
            delegate?.showDisclaimer(self)
            return false
        }
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        
        guard let collectionType = self.collectionType else {
            return false
        }
        var result = false
        if collectionType == .AppInterests {
            result = (self.interestsSelected?.count ?? 0) > 1
        } else if collectionType == .AppCategories {
            result = (self.categoriesSelected?.count ?? 0) > 1
        }
        
        if result {
            if delegate?.shouldShowDisclaimer(self) ?? false {
                
                self.currentIndexPath = indexPath
                self.select = false
                delegate?.showDisclaimer(self)
                return false
            }
        }
        
        return result
    }
}
