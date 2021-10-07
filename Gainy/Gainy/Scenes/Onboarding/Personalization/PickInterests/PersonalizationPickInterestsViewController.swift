//
//  PersonalizationPickInterestsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import UIKit


class PersonalizationPickInterestsViewController: BaseViewController {
    
    public weak var coordinator: OnboardingCoordinator?
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var appInterests: [AppInterestsQuery.Data.Interest]?
    private weak var footerView: PersonalizationPickInterestsFooterView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.setUpCollectionView()
        self.getRemoteData {
            self.setUpFooterView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Personalization", comment: "Personalization").uppercased()
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("personalization_interests_back", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
        self.coordinator?.popModule()
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("personalization_interests_close", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
        self.coordinator?.popToRootModule()
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = NSLocalizedString("Personalization", comment: "Personalization").uppercased()
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    private func setUpCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib.init(nibName: "PickInterestOrCategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier)
        self.collectionView.register(UINib.init(nibName: "PersonalizationPickInterestsHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PersonalizationPickInterestsHeaderView.reuseIdentifier)
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true
        let layout = UICollectionViewCenterAlignedLayout()
        layout.sectionFootersPinToVisibleBounds = true
        self.collectionView.collectionViewLayout = layout
    }
    
    private func setUpFooterView() {
        
        let footerView = UINib(nibName:"PersonalizationPickInterestsFooterView",bundle:.main).instantiate(withOwner: nil, options: nil).first as! PersonalizationPickInterestsFooterView
        footerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(footerView)
        
        footerView.autoPinEdge(toSuperviewEdge: .leading)
        footerView.autoPinEdge(toSuperviewEdge: .trailing)
        footerView.autoPinEdge(toSuperviewSafeArea: .bottom)
        footerView.autoSetDimension(.height, toSize: 101)
        self.footerView = footerView
        self.footerView?.delegate = self
        footerView.alpha = ((self.appInterests?.count ?? 0) > 0 ? 1.0 : 0.0)
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else {return}
        self.footerView?.setNextButtonHidden(hidden: indexPaths.count == 0)
    }
    
    private func getRemoteData(completion: @escaping () -> Void) {
        guard haveNetwork else {
            GainyAnalytics.logEvent("no_internet", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            completion()
            return
        }
        showNetworkLoader()
        Network.shared.apollo.fetch(query: AppInterestsQuery()) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let graphQLResult):
                
                guard let appInterests = graphQLResult.data?.interests else {
                    GainyAnalytics.logEvent("no_interests", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    self.hideLoader()
                    completion()
                    return
                }
                
                self.appInterests = appInterests
                self.collectionView.reloadData()
                completion()

            case .failure(let error):
                GainyAnalytics.logEvent("request_error", params: ["error" : "\(error)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
                print("Failure when making GraphQL request. Error: \(error)")
                NotificationManager.shared.showError("Sorry... Something went wrong. Please, try again later.")
                completion()
            }
            self.hideLoader()
        }
    }
}

extension PersonalizationPickInterestsViewController: PersonalizationPickInterestsFooterViewDelegate {
    
    func personalizationPickInterestsFooterDidTapNext(sender: Any) {
        
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else {return}
        var profileInterestIDs: [Int] = Array()
        for indexPath in indexPaths {
            if let appInterest = self.appInterests?[indexPath.row], let id = appInterest.id  {
                profileInterestIDs.append(id)
            }
        }
        self.coordinator?.profileInfoBuilder.profileInterestIDs = profileInterestIDs
        self.coordinator?.pushPersonalizationIndicatorsViewController()
    }
}

extension PersonalizationPickInterestsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell: PickInterestOrCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier, for: indexPath) as! PickInterestOrCategoryCell
        let appInterest: AppInterestsQuery.Data.Interest? = self.appInterests?[indexPath.row]
        cell.appInterest = appInterest
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.appInterests?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let appInterest: AppInterestsQuery.Data.Interest = self.appInterests?[indexPath.row] else {
            return CGSize.zero
        }
        
        let name = appInterest.name
        let width = name?.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width ?? 0.0
        var size = CGSize.init(width: (ceil(width) + CGFloat(64.0)), height: CGFloat(40))
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
        
        return UIEdgeInsets.init(top: 48.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.size.width, height: 138.0)
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PersonalizationPickInterestsHeaderView.reuseIdentifier, for: indexPath)
            result = headerView
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let interest = self.appInterests?[indexPath.row] else {return}
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else {return}
        self.footerView?.setNextButtonHidden(hidden: indexPaths.count == 0)
        GainyAnalytics.logEvent("personalization_select_interest", params: ["interest_id" : interest.id, "interest_name" : interest.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let interest = self.appInterests?[indexPath.row] else {return}
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else {return}
        self.footerView?.setNextButtonHidden(hidden: indexPaths.count == 0)
        GainyAnalytics.logEvent("personalization_deselect_interest", params: ["interest_id" : interest.id, "interest_name" : interest.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
    }
}
