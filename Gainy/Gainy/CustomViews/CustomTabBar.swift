//
//  CustomTabBar.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import UIKit
import PureLayout
import Combine

protocol CustomTabBarDelegate: AnyObject {
    func profileTabPressed(tabBar: CustomTabBar)
    func profileTabPressedLong(tabBar: CustomTabBar)
    func otherTabPressedLong(tabBar: CustomTabBar)
}

class CustomTabBar: UITabBar {
    
    private var cancellables = Set<AnyCancellable>()
    weak var customDelegate: CustomTabBarDelegate?
    
    enum Tab: Int {
        case discovery = 0, portfolio, profile
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
        cancellables.removeAll()
    }
    
    fileprivate func setupView() {
        addSubview(profileView)
        profileView.autoSetDimensions(to: .init(width: profileWidth, height: profileWidth))
        profileView.addSubview(profileImageView)
        profileImageView.autoPinEdgesToSuperviewEdges()
        NotificationCenter.default.publisher(for: Notification.Name.didPickProfileImage)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.profileImageView.image = self?.getProfileImage()
        }.store(in: &cancellables)
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
        
        let lastTabFrame = frameForTab(atIndex: 2)
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
}
