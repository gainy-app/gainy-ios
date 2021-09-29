//
//  CustomTabBar.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import UIKit
import PureLayout

protocol CustomTabBarDelegate: AnyObject {
    func profileTabPressed(tabBar: CustomTabBar)
    func profileTabPressedLong(tabBar: CustomTabBar)
    func otherTabPressedLong(tabBar: CustomTabBar)
}

class CustomTabBar: UITabBar {
    
    weak var customDelegate: CustomTabBarDelegate?
    
    enum Tab: Int {
        case discovery = 0, portfolio, analytics, profile
    }
    
    private let profileWidth: CGFloat = 24.0
    lazy var profileView: UIView = {
        let profileView = UIView(frame: CGRect.init(x: 0, y: 0, width: profileWidth, height: profileWidth))
        profileView.backgroundColor = .green
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
        profileView.image = getProfileImage()
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
    }
    
    fileprivate func setupView() {
        addSubview(profileView)
        profileView.autoPinEdge(.top, to: .top, of: self, withOffset: 8.0)
        profileView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -35)
        profileView.autoSetDimensions(to: .init(width: profileWidth, height: profileWidth))
        profileView.addSubview(profileImageView)
        profileImageView.autoPinEdgesToSuperviewEdges()
        NotificationCenter.default.addObserver(self, selector: #selector(didPickProfilePicture), name: NSNotification.Name.didPickProfileImage, object: nil)
        
//        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
//        addGestureRecognizer(panRecognizer)
//        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.babyChanged), name: NSNotification.Name(rawValue: NotificationManager.currentBabyChangedNotification), object: nil)

//        addSubview(feedingIndicator)
//        feedingIndicator.snp.makeConstraints { make in
//            make.left.equalTo(self).offset(UIScreen.main.bounds.width / 5.0 * 1.5 - 6.0)
//            make.top.equalTo(self).offset(-6.0)
//            make.width.equalTo(12.0)
//            make.height.equalTo(12.0)
//        }
    }
    
    @objc func babyChanged() {
    }
    
    @objc func didPickProfilePicture() {
        
        profileImageView.image = getProfileImage()
    }
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview)
        print(translation)
    }
    
    var firstTabFrame: CGRect {
        return CGRect.init(x: 0, y: 0, width: bounds.width / 5.0, height: bounds.height)
    }
    
    @objc func longPressAction(_ recognizer: UILongPressGestureRecognizer) {
        self.customDelegate?.profileTabPressedLong(tabBar: self)
    }
    
    @objc func pressAction(_ recognizer: UILongPressGestureRecognizer) {
        self.customDelegate?.profileTabPressed(tabBar: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(profileView)
        layer.shadowOffset = CGSize.init(width: 0.0, height: 0.5)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor(hexString: "#4F6169", alpha: Float(0.1))?.cgColor
    }
    
    override var selectedItem: UITabBarItem? {
        didSet {
            let oldTab = Tab.init(rawValue: oldValue?.tag ?? 0)!
            let newTab = Tab.init(rawValue: selectedItem?.tag ?? 0)!
            if oldTab != newTab {
                self.customDelegate?.otherTabPressedLong(tabBar: self)
                //Possible selection
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let location = touches.first?.location(in: self) else {return}
        if firstTabFrame.contains(location) {
            
        }
    }
    
    private func getProfileImage() -> UIImage? {
        
        let fileName = "profile.png"
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                                    appropriateFor: nil,
                                                                    create: false)
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if let image = UIImage.init(fileURLWithPath: fileURL) {
                return image
                NotificationCenter.default.post(name: NSNotification.Name.didPickProfileImage, object: nil)
            } else {
                return UIImage.init(named: "profilePlaceholder")
            }
        }
        catch {
            return UIImage.init(named: "profilePlaceholder")
        }
    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {return}
//
//        print(touch.location(in: self).y)
//    }
}
