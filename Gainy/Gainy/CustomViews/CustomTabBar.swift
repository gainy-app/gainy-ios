//
//  CustomTabBar.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import UIKit
import PureLayout
import Combine
import FirebaseStorage
import Kingfisher

protocol CustomTabBarDelegate: AnyObject {
    func profileTabPressed(tabBar: CustomTabBar)
    func profileTabPressedLong(tabBar: CustomTabBar)
    func otherTabPressedLong(tabBar: CustomTabBar)
}

class CustomTabBar: UITabBar {
    
    private var cancellables = Set<AnyCancellable>()
    weak var customDelegate: CustomTabBarDelegate?
    
    enum Tab: Int {
        case home = 0, discovery, portfolio, profile
        
        init(title: String) {
            switch title {
            case "Home":
                self = .home
            case "Discovery":
                self = .discovery
            case "Portfolio":
                self = .portfolio
            case "Profile":
                self = .profile
            default:
                self = .discovery
            }
        }
    }
    
    private let profileWidth: CGFloat = 24.0
    lazy var profileView: UIView = {
        let profileView = UIView(frame: CGRect.init(x: 0, y: 0, width: profileWidth, height: profileWidth))
        profileView.backgroundColor = .clear
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 8.0
        profileView.isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction(_:)))
        profileView.addGestureRecognizer(longPressGesture)
        
        let tapPressGesture = UITapGestureRecognizer.init(target: self, action: #selector(pressAction(_:)))
        profileView.addGestureRecognizer(tapPressGesture)
        return profileView
    }()
    
    lazy var profileImageView: UIImageView = {
        let profileView = UIImageView()
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 8
        profileView.contentMode = .scaleAspectFill
        return profileView
    }()
    
    
    var selectedIndex: Tab = .discovery
    
    var haveAddedChildren: Bool = false {
        didSet {
            updateTabs()
        }
    }
    
    lazy var profileIndicator: UIView = create { indicatorView  in
        indicatorView.layer.cornerRadius = 6.0
    }
    
   
    func updateTabs() {
        //Update profileIndicator if needed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        cancellables.removeAll()
    }
    
    fileprivate func setupView() {
        
//        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
//        frost.frame = bounds
//        frost.autoresizingMask = .flexibleWidth
//        insertSubview(frost, at: 0)
        
        addSubview(profileView)
        profileView.autoSetDimensions(to: .init(width: profileWidth, height: profileWidth))
        profileView.addSubview(profileImageView)
        profileImageView.autoPinEdgesToSuperviewEdges()
        profileImageView.backgroundColor = UIColor.clear
        profileImageView.image = nil
        NotificationCenter.default.publisher(for: Notification.Name.didPickProfileImage)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.updateProfileImage()
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: Notification.Name.didLoadProfile)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.updateProfileImage()
        }.store(in: &cancellables)
    }
    
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
    }
    
    var firstTabFrame: CGRect {
        return CGRect.init(x: 0, y: 0, width: bounds.width / 5.0, height: bounds.height)
    }
    
    @objc func longPressAction(_ recognizer: UILongPressGestureRecognizer) {
        self.customDelegate?.profileTabPressedLong(tabBar: self)
    }
    
    @objc func pressAction(_ recognizer: UILongPressGestureRecognizer) {
        self.customDelegate?.profileTabPressed(tabBar: self)
        GainyAnalytics.logEvent("tab_changed", params: ["tab" : "Profile", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TabBar"])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(profileView)
        layer.shadowOffset = CGSize.init(width: 0.0, height: 0.5)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor(hexString: "#4F6169", alpha: Float(0.1))?.cgColor
        
        let lastTabFrame = frameForTab(atIndex: 3)
        profileView.center = CGPoint(x: lastTabFrame.midX, y: lastTabFrame.midY - 5)
    }
    
    private func frameForTab(atIndex index: Int) -> CGRect {
        var frames = subviews.compactMap { (view:UIView) -> CGRect? in
            if let view = view as? UIControl {
                return view.frame
            }
            return nil
        }
        frames.sort { $0.origin.x < $1.origin.x }
        if frames.count > index {
            return frames[index]
        }
        return frames.last ?? CGRect.zero
    }
    
    override var selectedItem: UITabBarItem? {
        didSet {
            let oldTab = Tab.init(title: oldValue?.title ?? "")
            let newTab = Tab.init(title: selectedItem?.title ?? "")
            if oldTab != newTab {
                self.customDelegate?.otherTabPressedLong(tabBar: self)
                //Possible selection
            }
            if newTab == .portfolio {
                NotificationCenter.default.post(name: NotificationManager.portoTabPressedNotification, object: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let location = touches.first?.location(in: self) else {return}
        if firstTabFrame.contains(location) {
            
        }
    }
    
    private func updateProfileImage() {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()

        // Create a storage reference from our storage service
        let storageRef = storage.reference()

        let avatarFileName = "avatar_\(profileID).png"
        // Create a reference to 'avatars/<avatarFileName>'
        let avatarImageRef = storageRef.child("avatars/\(avatarFileName)")
        avatarImageRef.downloadURL { (url, error) in
            
            guard let downloadURL = url else {
                self.profileImageView.image = UIImage.init(named: "profilePlaceholder")
                return
            }
            
            let processor = DownsamplingImageProcessor(size: self.profileImageView.bounds.size)
            self.profileImageView.kf.setImage(with: downloadURL, placeholder: UIImage(), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { receivedSize, totalSize in
    //            print("-----\(receivedSize), \(totalSize)")
            } completionHandler: { result in
            }
        }
    }
}
