//
//  ProfileViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import Foundation
import UIKit
import MessageUI
import PureLayout
import Combine
import AvatarImagePicker
import FirebaseStorage
import Kingfisher

final class ProfileViewController: BaseViewController {
    
    @IBOutlet private weak var categoriesHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var interestsHeightConstraint: NSLayoutConstraint!
    
    weak var authorizationManager: AuthorizationManager?
    weak var mainCoordinator: MainCoordinator?
    
    private var profileInterests: [AppInterestsQuery.Data.Interest]?
    private var profileInterestsSelected: [AppInterestsQuery.Data.Interest]?
    private var appInterests: [AppInterestsQuery.Data.Interest]?
    private var profileCategories: [CategoriesQuery.Data.Category]?
    private var profileCategoriesSelected: [CategoriesQuery.Data.Category]?
    private var appCategories: [CategoriesQuery.Data.Category]?
    
    @IBOutlet private weak var addProfilePictureButton: UIButton!
    @IBOutlet private weak var logoutButton: BorderButton!
    @IBOutlet private weak var requestFeatureButton: BorderButton!
    @IBOutlet private weak var sendFeedbackButton: BorderButton! {
        didSet {
            sendFeedbackButton.layer.borderWidth = 2.0
        }
    }
    @IBOutlet private weak var privacyButton: UIButton!
    @IBOutlet private weak var relLaunchOnboardingQuestionnaireButton: UIButton!
    @IBOutlet private weak var personalInfoButton: UIButton!
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    @IBOutlet private weak var interestsCollectionView: UICollectionView!
    @IBOutlet private weak var profilePictureImageView: UIImageView!
    @IBOutlet private weak var fullNameTitle: UILabel!
    @IBOutlet private weak var versionLbl: UILabel! {
        didSet {
            versionLbl.text = "\(Bundle.main.releaseVersionNumberPretty) #\(Bundle.main.buildVersionNumber ?? "")"
        }
    }
    
    private var currentCollectionView: UICollectionView?
    private var currentIndexPath: IndexPath?
    
    private var disclaimerShownKey: String? {
        get {
            guard let profileID = UserProfileManager.shared.profileID else {
                return nil
            }
            
            let key = "disclaimerShownForProfileWithID" + "\(profileID)" + ".prod.v1.0.1"
            return key
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureProfilePictureSection()
        configureButtons()
        setUpCollectionView(interestsCollectionView)
        setUpCollectionView(categoriesCollectionView)
        subscribeOnUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.reloadData(refetchProfile: true)
    }
    
    public func loadProfileInterestsIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        
        guard UserProfileManager.shared.profileID != nil else {
            completion(false)
            return
        }
        
        if self.profileInterests == nil {
            self.loadProfileInterests(completion: completion)
        } else {
            completion(true)
        }
    }
    
    public func loadProfileCategoriesIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        
        guard UserProfileManager.shared.profileID != nil else {
            completion(false)
            return
        }
        
        if self.profileCategories == nil {
            self.loadProfileCategories(completion: completion)
        } else {
            completion(true)
        }
    }
    
    public func loadProfileInterests(completion: @escaping (_ success: Bool) -> Void) {
        
        let profileInterestsIds = UserProfileManager.shared.interests
        guard profileInterestsIds.count > 0 else {
            completion(false)
            return
        }
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: AppInterestsQuery()) { [weak self] result in
            guard let self = self else {return}
            self.hideLoader()
            switch result {
            case .success(let graphQLResult):
                
                guard let appInterests = graphQLResult.data?.interests else {
                    NotificationManager.shared.showError("Sorry... Failed to load app interests.")
                    completion(false)
                    return
                }
                
                var health: [AppInterestsQuery.Data.Interest] = []
                self.appInterests = appInterests.compactMap({ item in
                    if item.id == 50 || item.id == 55 {
                        health.append(item)
                        return nil
                    }
                    return item
                })
                if let interests = self.appInterests {
                    self.appInterests?.insert(contentsOf: health, at: interests.count / 2)
                }
                
                self.profileInterests = self.appInterests?.filter({ interest in
                    guard let interestID = interest.id else {
                        return false
                    }
                    return profileInterestsIds.contains(interestID)
                })
                self.profileInterestsSelected = self.profileInterests
                completion(true)
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                NotificationManager.shared.showError("Sorry... Something went wrong. Please, try again later.")
                completion(false)
            }
        }
    }
    
    public func loadProfileCategories(completion: @escaping (_ success: Bool) -> Void) {
        
        let profileCategoryIds = UserProfileManager.shared.categories
        guard profileCategoryIds.count > 0 else {
            completion(false)
            return
        }
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: CategoriesQuery()) { [weak self] result in
            guard let self = self else {return}
            self.hideLoader()
            switch result {
            case .success(let graphQLResult):
                guard let appCategories = graphQLResult.data?.categories else {
                    NotificationManager.shared.showError("Sorry... Failed to load app categories.")
                    completion(false)
                    return
                }
                
                self.appCategories = appCategories
                self.profileCategories = self.appCategories?.filter({ category in
                    guard let categoryID = category.id else {
                        return false
                    }
                    return profileCategoryIds.contains(categoryID)
                })
                self.profileCategoriesSelected = self.profileCategories
                completion(true)
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                NotificationManager.shared.showError("Sorry... Something went wrong. Please, try again later.")
                completion(false)
            }
        }
    }
    
    public func loadProfile(completion: @escaping (_ success: Bool) -> Void) {
        
        showNetworkLoader()
        UserProfileManager.shared.fetchProfile { success in
            self.hideLoader()
            completion(success)
        }
    }
    
    @IBAction func addProfilePictureButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("profile_add_picture_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        
        let picker = AvatarImagePicker.instance
        picker.dismissAnimated = true
#if targetEnvironment(simulator)
        picker.sourceTypes = [.photoLibrary]
#else
        picker.sourceTypes = [.camera, .photoLibrary]
#endif
        picker.presentStyle = .overFullScreen
        
        // this method includes authorizing for photolibrary and camera.
        picker.present(allowsEditing: true, selected: { (image) in
            
            self.profilePictureImageView.image = image
            guard let profileID = UserProfileManager.shared.profileID else {
                return
            }
            // Data in memory
            guard let data = image.pngData() else {
                return
            }
            
            // Get a reference to the storage service using the default Firebase App
            let storage = Storage.storage()

            // Create a storage reference from our storage service
            let storageRef = storage.reference()

            let avatarFileName = "avatar_\(profileID).png"
            // Create a reference to 'avatars/<avatarFileName>'
            let avatarImageRef = storageRef.child("avatars/\(avatarFileName)")

            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = avatarImageRef.putData(data, metadata: nil) { (metadata, error) in
                guard error != nil else {
                    return
                }
                GainyAnalytics.logEvent("profile_finished_pick_image", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
                NotificationCenter.default.post(name: NSNotification.Name.didPickProfileImage, object: nil)
            }
            uploadTask.resume()
        }) {
            GainyAnalytics.logEvent("profile_cancelled_pick_image", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        }
    }
    
    @IBAction func reLaunchOnboardingButtonTap(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("Are you sure want to re-launch onboarding questionnaire? It might significantly affect your overall recommendations.", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
            
        }
        let proceedAction = UIAlertAction(title: NSLocalizedString("Proceed", comment: ""), style: .default) { (action) in
            GainyAnalytics.logEvent("profile_re_launch_onboarding_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
            self.reLaunchOnboarding()
        }
        alertController.addAction(proceedAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func privacyInfoButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("profile_privacy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if let vc = self.mainCoordinator?.viewControllerFactory.instantiatePrivacy() {
            let navigationController = UINavigationController.init(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        } else if let url = URL(string: Constants.Links.privacy) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func personalInfoButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("profile_personal_info_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if let vc = self.mainCoordinator?.viewControllerFactory.instantiateEditPersonalInfo() {
            vc.delegate = self
            let navigationController = UINavigationController.init(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onRequestFeatureTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("profile_request_feature_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if let url = URL.init(string: "https://gainy.canny.io") {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onSendFeedbackTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("profile_send_feedback_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            let recipientEmail = "support@gainy.app"
            mailComposer.setToRecipients([recipientEmail])
            present(mailComposer, animated: true)
            
        } else if let emailUrl = URL.init(string: "support@gainy.app") {
            //WebPresenter.openLink(vc: self, url: emailUrl)
        }
    }
    
    @IBAction func onLogOutTap(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("Are you sure you want to log out?", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel) { (action) in
            
        }
        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { (action) in
            
            GainyAnalytics.logEvent("profile_log_out_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
            self.authorizationManager?.signOut()
            NotificationCenter.default.post(name: NotificationManager.userLogoutNotification, object: nil)
            if let finishFlow = self.mainCoordinator?.finishFlow {
                finishFlow()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onViewAllCategoriesTap(_ sender: Any) {
        
        guard let coordinator = self.mainCoordinator else {
            return
        }
        guard let categories = self.appCategories, let selected = self.profileCategoriesSelected else {
            return
        }
        
        GainyAnalytics.logEvent("profile_view_all_categories_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if let vc = self.mainCoordinator?.viewControllerFactory.instantiateEditProfileCollectionInfo(coordinator: coordinator) {
            vc.configure(with: categories, categoriesSelected: selected)
            vc.delegate = self
            vc.dismissHandler = {
                self.reloadData()
            }
            let navigationController = UINavigationController.init(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onViewAllInterestsTap(_ sender: Any) {
        
        guard let coordinator = self.mainCoordinator else {
            return
        }
        guard let interests = self.appInterests, let selected = self.profileInterestsSelected else {
            return
        }
        
        GainyAnalytics.logEvent("profile_view_all_interests_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
        if let vc = self.mainCoordinator?.viewControllerFactory.instantiateEditProfileCollectionInfo(coordinator: coordinator) {
            vc.configure(with: interests, interestsSelected: selected)
            vc.delegate = self
            vc.dismissHandler = {
                self.reloadData()
            }
            let navigationController = UINavigationController.init(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    public func refreshProfileData() {
        
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        
        loadProfile { success in
            guard success, let firstName = UserProfileManager.shared.firstName, let lastName = UserProfileManager.shared.lastName else {
                return
            }

            self.fullNameTitle.text = firstName + " " + lastName
            self.loadProfileSpecificContent()
        }
    }
    
    private func loadProfileData() {
        
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        
        guard let profileLoaded = UserProfileManager.shared.profileLoaded, profileLoaded == true else {
            self.refreshProfileData()
            return
        }
        self.loadProfileSpecificContent()
    }
    
    private func loadProfileSpecificContent() {
        
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        
        self.loadProfileInterestsIfNeeded { success in
            
            if !success { return }
            self.updateProfileInterestsUI()
        }
        
        self.loadProfileCategoriesIfNeeded { success in
            
            if !success { return }
            self.updateProfileCategoriesUI()
        }
    }
    
    private func reloadData(refetchProfile: Bool = false) {
        
        if (refetchProfile) {
            self.refreshProfileData()
            return
        }
        
        self.loadProfileData()
        self.interestsCollectionView.reloadData()
        self.categoriesCollectionView.reloadData()
    }
    
    private func updateProfileInterestsUI() {
        
        guard let profileInterests = self.profileInterests, profileInterests.count > 0 else {
            return
        }
        
        if profileInterests.count == 1 {
            self.interestsHeightConstraint.constant = 40.0
        } else if profileInterests.count == 2 {
            self.interestsHeightConstraint.constant = 92.0
        } else {
            self.interestsHeightConstraint.constant = 144
        }
        self.view.setNeedsLayout()
        self.interestsCollectionView.reloadData()
    }
    
    private func updateProfileCategoriesUI() {
        
        guard let profileCategories = self.profileCategories, profileCategories.count > 0 else {
            return
        }
        
        if profileCategories.count == 1 {
            self.categoriesHeightConstraint.constant = 40.0
        } else {
            self.categoriesHeightConstraint.constant = 92.0
        }
        self.view.setNeedsLayout()
        self.categoriesCollectionView.reloadData()
    }
    
    private func configureProfilePictureSection() {
        
        profilePictureImageView.contentMode = .scaleAspectFill
        
        addProfilePictureButton.setTitle(nil, for: UIControl.State.normal)
        addProfilePictureButton.layer.shadowOffset = CGSize.init(width: 2.5, height: 2.5)
        addProfilePictureButton.layer.shadowRadius = 10.0
        addProfilePictureButton.layer.shadowOpacity = 1.0
        addProfilePictureButton.layer.shadowColor = UIColor(hexString: "#4F6169", alpha: Float(0.1))?.cgColor
        addProfilePictureButton.contentMode = .center
        addProfilePictureButton.imageView?.contentMode = .scaleAspectFit
        
        profilePictureImageView.layer.cornerRadius = 24.0
        profilePictureImageView.layer.borderWidth = 3.0
        profilePictureImageView.layer.borderColor = UIColor(hexString: "#0062FF", alpha: 1.0)?.cgColor
        profilePictureImageView.layer.masksToBounds = true
        
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        
        self.profilePictureImageView.image = nil
        self.profilePictureImageView.isSkeletonable = true
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()

        // Create a storage reference from our storage service
        let storageRef = storage.reference()

        let avatarFileName = "avatar_\(profileID).png"
        // Create a reference to 'avatars/<avatarFileName>'
        let avatarImageRef = storageRef.child("avatars/\(avatarFileName)")
        avatarImageRef.downloadURL { (url, error) in
            
            guard let downloadURL = url else {
                self.profilePictureImageView.isSkeletonable = false
                self.profilePictureImageView.image = UIImage.init(named: "profilePlaceholder")
                return
            }
            
            let processor = DownsamplingImageProcessor(size: self.profilePictureImageView.bounds.size)
            self.profilePictureImageView.kf.setImage(with: downloadURL, placeholder: UIImage(), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { receivedSize, totalSize in
    //            print("-----\(receivedSize), \(totalSize)")
            } completionHandler: { result in
                self.profilePictureImageView.isSkeletonable = false
            }
        }
    }
    
    private func configureButtons() {
        
        let privacyTitle = NSLocalizedString("Privacy", comment: "Privacy")
        privacyButton.setTitle("", for: UIControl.State.normal)
        privacyButton.titleLabel?.alpha = 0.0
        let privacyLabel = UILabel.newAutoLayout()
        privacyLabel.font = UIFont.proDisplaySemibold(20.0)
        privacyLabel.textAlignment = NSTextAlignment.left
        privacyLabel.text = privacyTitle
        privacyButton.addSubview(privacyLabel)
        privacyLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.right)
        privacyLabel.sizeToFit()
        privacyLabel.isUserInteractionEnabled = false
        let privacyImageView = UIImageView.newAutoLayout()
        privacyImageView.image = UIImage.init(named: "iconChevronRight")
        privacyButton.addSubview(privacyImageView)
        privacyImageView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        privacyImageView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        privacyImageView.isUserInteractionEnabled = false
        
        let personalInformation = NSLocalizedString("Personal information", comment: "Personal information")
        personalInfoButton.setTitle("", for: UIControl.State.normal)
        personalInfoButton.titleLabel?.alpha = 0.0
        let personalInfoLabel = UILabel.newAutoLayout()
        personalInfoLabel.font = UIFont.proDisplaySemibold(20.0)
        personalInfoLabel.textAlignment = NSTextAlignment.left
        personalInfoLabel.text = personalInformation
        personalInfoButton.addSubview(personalInfoLabel)
        personalInfoLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.right)
        personalInfoLabel.sizeToFit()
        personalInfoLabel.isUserInteractionEnabled = false
        let personalInfoImageView = UIImageView.newAutoLayout()
        personalInfoImageView.image = UIImage.init(named: "iconChevronRight")
        personalInfoButton.addSubview(personalInfoImageView)
        personalInfoImageView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        personalInfoImageView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        personalInfoImageView.isUserInteractionEnabled = false
        
        let onboadring = NSLocalizedString("Re-launch onboarding", comment: "Re-launch onboarding")
        relLaunchOnboardingQuestionnaireButton.setTitle("", for: UIControl.State.normal)
        relLaunchOnboardingQuestionnaireButton.titleLabel?.alpha = 0.0
        let onboardingLabelLabel = UILabel.newAutoLayout()
        onboardingLabelLabel.font = UIFont.proDisplaySemibold(20.0)
        onboardingLabelLabel.textAlignment = NSTextAlignment.left
        onboardingLabelLabel.text = onboadring
        relLaunchOnboardingQuestionnaireButton.addSubview(onboardingLabelLabel)
        onboardingLabelLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: ALEdge.right)
        onboardingLabelLabel.sizeToFit()
        onboardingLabelLabel.isUserInteractionEnabled = false
        let onboardingImageView = UIImageView.newAutoLayout()
        onboardingImageView.image = UIImage.init(named: "iconChevronRight")
        relLaunchOnboardingQuestionnaireButton.addSubview(onboardingImageView)
        onboardingImageView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        onboardingImageView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        onboardingImageView.isUserInteractionEnabled = false
        
    }
    
    private func setUpCollectionView(_ collectionView: UICollectionView!) {
        
        let layout = UICollectionViewLeftAlignedHorizontalLayout()
        if collectionView == categoriesCollectionView {
            layout.maxNumberOfRows = 2
        }
        layout.delegate = self
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView.register(UINib.init(nibName: "PickInterestOrCategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier)
        collectionView?.allowsSelection = true
        collectionView?.allowsMultipleSelection = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: -20.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    private func subscribeOnUpdates() {
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateScoringSettings).sink { _ in
        } receiveValue: { notification in
            self.reloadData()
            self.didChangeSettings(nil)
        }.store(in: &cancellables)
    }
    
    private func reLaunchOnboarding(_ sender: EditProfileCollectionViewController? = nil) {
        
        let vc = PersonalizationIndicatorsViewController.instantiate(.onboarding)
        vc.mainCoordinator = self.mainCoordinator
        let navigationController = UINavigationController.init(rootViewController: vc)
        if let sender = sender {
            sender.dismiss(animated: true) {
                self.present(navigationController, animated: true, completion: nil)
            }
        } else {
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    private func proceedEditing() {
        
        guard let indexPath = self.currentIndexPath else { return }
        guard let collectionView = self.currentCollectionView else { return }
        
        self.didChangeSettings(nil)
        
        self.categoriesCollectionView.deselectItem(at: indexPath, animated: false)
        self.collectionView(collectionView, didDeselectItemAt: indexPath)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewLeftAlignedHorizontalLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: PickInterestOrCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickInterestOrCategoryCell.reuseIdentifier, for: indexPath) as! PickInterestOrCategoryCell
        var isSelected: Bool = false
        if collectionView == self.interestsCollectionView {
            let profileInterest: AppInterestsQuery.Data.Interest? = self.profileInterests?[indexPath.row]
            cell.appInterest = profileInterest
            
            if let selected = (profileInterestsSelected?.contains(where: {$0.id == profileInterest!.id })) {
                isSelected = selected
            }
        } else {
            let profileCategory: CategoriesQuery.Data.Category? = self.profileCategories?[indexPath.row]
            cell.appCategory = profileCategory
            
            if let selected = (profileCategoriesSelected?.contains(where: {$0.id == profileCategory!.id })) {
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
        if collectionView == self.interestsCollectionView {
            return self.profileInterests?.count ?? 0
        } else {
            return self.profileCategories?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var name: String? = nil
        if collectionView == self.interestsCollectionView {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.profileInterests?[indexPath.row] else {
                return CGSize.zero
            }
            name = profileInterest.name
        } else {
            guard let profileCategory: CategoriesQuery.Data.Category = self.profileCategories?[indexPath.row] else {
                return CGSize.zero
            }
            name = profileCategory.name
        }
        guard let name = name else {
            return CGSize.zero
        }
        
        let width = name.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width
        let size = CGSize.init(width: (ceil(width) + CGFloat(56)), height: CGFloat(40))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(12.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(12.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0.0, left: 17.0, bottom: 0.0, right: 17.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.interestsCollectionView {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.profileInterests?[indexPath.row] else {
                return
            }
            self.didSelectInterest(nil, profileInterest)
        } else {
            guard let profileCategory: CategoriesQuery.Data.Category = self.profileCategories?[indexPath.row] else {
                return
            }
            self.didSelectCategory(nil, profileCategory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == self.interestsCollectionView {
            guard let profileInterest: AppInterestsQuery.Data.Interest = self.profileInterests?[indexPath.row] else {
                return
            }
            self.didDeselectInterest(nil, profileInterest)
            self.profileInterests?.removeAll(where: { element in
                element.id == profileInterest.id
            })
            self.profileInterestsSelected?.removeAll(where: { element in
                element.id == profileInterest.id
            })
            collectionView.reloadData()
            self.updateProfileInterestsUI()
        } else {
            guard let profileCategory: CategoriesQuery.Data.Category = self.profileCategories?[indexPath.row] else {
                return
            }
            self.didDeselectCategory(nil, profileCategory)
            self.profileCategoriesSelected?.removeAll(where: { element in
                element.id == profileCategory.id
            })
            self.profileCategories?.removeAll(where: { element in
                element.id == profileCategory.id
            })
            collectionView.reloadData()
            self.updateProfileCategoriesUI()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        
        var result = false
        if collectionView == self.interestsCollectionView {
            result = (self.profileInterestsSelected?.count ?? 0) > 1
        } else {
            result = (self.profileCategoriesSelected?.count ?? 0) > 1
        }
        
        if result {
            if self.shouldShowDisclaimer(nil) {
                self.currentIndexPath = indexPath
                self.currentCollectionView = collectionView
                self.showDisclaimer(nil)
                return false
            }
        }
        
        return result
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: EditProfileCollectionViewControllerDelegate {
    
    func didSelectInterest(_ sender: EditProfileCollectionViewController?, _ interest: AppInterestsQuery.Data.Interest) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        guard let interestID = interest.id else {
            return
        }
        
        let query = InsertProfileInterestMutation.init(profileID: profileID, interestID: interestID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... We couldn't save your profile information. Please, try again later.")
                return
            }
            
            GainyAnalytics.logEvent("profile_select_interest", params: ["profileID" : "\(profileID)", "interestID" : "\(interestID)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
            self.profileInterestsSelected?.append(interest)
            let index = self.profileInterests?.lastIndex(where: { element in
                element.id == interest.id
            })
            if index == nil {
                self.profileInterests?.append(interest)
            }
            NotificationCenter.default.post(name: NSNotification.Name.didChangeProfileInterests, object: nil)
        }
    }
    
    func didDeselectInterest(_ sender: EditProfileCollectionViewController?, _ interest: AppInterestsQuery.Data.Interest) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        guard let interestID = interest.id else {
            return
        }
        
        let index = self.profileInterestsSelected?.lastIndex(where: { element in
            element.id == interest.id
        })
        if index != nil {
            let query = DeleteProfileInterestMutation.init(profileID: profileID, interestID: interestID)
            Network.shared.apollo.perform(mutation: query) { result in
                dprint("\(result)")
                guard (try? result.get().data) != nil else {
                    NotificationManager.shared.showError("Sorry... We couldn't save your profile information. Please, try again later.")
                    return
                }
                
                GainyAnalytics.logEvent("profile_deselect_interest", params: ["profileID" : "\(profileID)", "interestID" : "\(interestID)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
                self.profileInterestsSelected?.removeAll(where: { element in
                    element.id == interestID
                })
                self.profileInterests?.removeAll(where: { element in
                    element.id == interestID
                })
                NotificationCenter.default.post(name: NSNotification.Name.didChangeProfileInterests, object: nil)
            }
        }
    }
    
    func didSelectCategory(_ sender: EditProfileCollectionViewController?, _ category: CategoriesQuery.Data.Category) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        guard let categoryID = category.id else {
            return
        }
        
        let query = InsertProfileCategoryMutation.init(profileID: profileID, categoryID: categoryID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... We couldn't save your profile information. Please, try again later.")
                return
            }
            
            GainyAnalytics.logEvent("profile_select_category", params: ["profileID" : "\(profileID)", "categoryID" : "\(categoryID)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
            self.profileCategoriesSelected?.append(category)
            let index = self.profileCategories?.lastIndex(where: { element in
                element.id == category.id
            })
            if index == nil {
                self.profileCategories?.append(category)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name.didChangeProfileCategories, object: nil)
        }
    }
    
    func didDeselectCategory(_ sender: EditProfileCollectionViewController?, _ category: CategoriesQuery.Data.Category) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        guard let categoryID = category.id else {
            return
        }
        
        let index = self.profileCategoriesSelected?.lastIndex(where: { element in
            element.id == category.id
        })
        if index != nil {
            let query = DeleteProfileCategoryMutation.init(profileID: profileID, categoryID: categoryID)
            Network.shared.apollo.perform(mutation: query) { result in
                dprint("\(result)")
                guard (try? result.get().data) != nil else {
                    NotificationManager.shared.showError("Sorry... We couldn't save your profile information. Please, try again later.")
                    return
                }
                
                GainyAnalytics.logEvent("profile_deselect_category", params: ["profileID" : "\(profileID)", "categoryID" : "\(categoryID)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
                self.profileCategoriesSelected?.removeAll(where: { element in
                    element.id == categoryID
                })
                self.profileCategories?.removeAll(where: { element in
                    element.id == categoryID
                })
                NotificationCenter.default.post(name: NSNotification.Name.didChangeProfileCategories, object: nil)
            }
        }
    }
    
    func didChangeSettings(_ sender: EditProfileCollectionViewController?) {
        
        guard let disclaimerShownKey = self.disclaimerShownKey else { return }
        
        UserDefaults.standard.set(true, forKey: disclaimerShownKey)
        UserDefaults.standard.synchronize()
    }
    
    func shouldShowDisclaimer(_ sender: EditProfileCollectionViewController?) -> Bool {
        
        guard let disclaimerShownKey = self.disclaimerShownKey else { return false }
        
        let value = UserDefaults.standard.bool(forKey: disclaimerShownKey)
        return !value
    }
    
    func showDisclaimer(_ sender: EditProfileCollectionViewController?) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("Changing Interests and Categories might significantly affect your overall recommendations. If you are not sure, it’s better to re-launch onboarding questionnaire instead.", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
            
        }
        let proceedAction = UIAlertAction(title: NSLocalizedString("Proceed", comment: ""), style: .destructive) { (action) in
            if let sender = sender {
                sender.proceedEditing()
            } else {
                self.proceedEditing()
            }
        }
        let reLaunchOnboardingAction = UIAlertAction(title: NSLocalizedString("Re-launch onboarding", comment: ""), style: .default) { (action) in
            self.reLaunchOnboarding(sender)
        }
        alertController.addAction(proceedAction)
        alertController.addAction(reLaunchOnboardingAction)
        alertController.addAction(cancelAction)
        if let sender = sender {
            sender.present(alertController, animated: true, completion: nil)
        } else {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ProfileViewController: EditPersonalInfoViewControllerDelegate {
    
    func didUpdateProfile(with firstName:String, lastName:String, email:String, legalAddress:String) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
  
        let query = UpdateProfileMutation.init(profileID: profileID, firstName: firstName, lastName: lastName, email: email, legalAddress: legalAddress)
        showNetworkLoader()
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            self.hideLoader()
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... We couldn't save your profile information. Please, try again later.")
                return
            }
            
            GainyAnalytics.logEvent("profile_did_change_personal_info", params: ["profileID" : "\(profileID)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView"])
            self.fullNameTitle.text = firstName + " " + lastName
            UserProfileManager.shared.firstName = firstName
            UserProfileManager.shared.lastName = lastName
            UserProfileManager.shared.email = email
            UserProfileManager.shared.address = legalAddress
        }
    }
}
