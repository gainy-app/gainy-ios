//
//  FloatingPanelManager.swift
//  Gainy
//
//  Created by Serhii Borysov on 10/22/21.
//

import Foundation
import UIKit
import FloatingPanel

class FloatingPanelManager: NSObject {
    
    private weak var vc: UIViewController?
    private var fpc: FloatingPanelController?
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private var layout = DefaultFloatingPanelLayout()
    
    // Singleton
    static let shared = FloatingPanelManager()
    
    fileprivate override init() {
        super.init()
    }
    
    public func configureWithHeight(height: CGFloat) {
        
        self.layout.configureWithHeight(height: height)
    }
    
    public func setupFloatingPanelWithViewController(viewController: UIViewController) {
        
        if let prevFpc = fpc {
            vc = nil
            fpc = nil
            prevFpc.dismiss(animated: false, completion: nil)
        }
        fpc = FloatingPanelController()
        guard let fpc = self.fpc else {
            return
        }
        
        vc = viewController
        fpc.layout = layout
        let appearance = SurfaceAppearance()
        
        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        
        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        // Set a content view controller.
        fpc.set(contentViewController: viewController)
        fpc.isRemovalInteractionEnabled = true
        fpc.backdropView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc
    func handleTap(gesture _: UITapGestureRecognizer) {
        fpc?.dismiss(animated: true, completion: nil)
    }
    
    public func showFloatingPanel() {
        
        guard let fpc = self.fpc else {
            return
        }
        
        if let topViewController = BaseViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(fpc, animated: true, completion: nil)
            }
        }
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        return gesture
    }()
    
    class DefaultFloatingPanelLayout: FloatingPanelLayout {
        
        private var height: CGFloat = 155.0
        
        public func configureWithHeight(height: CGFloat) {
           
            self.height = height
        }
        
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .full,
                    .half,
                    .tip: return 0.3
            default: return 0.0
            }
        }
    }
}



extension FloatingPanelManager: FloatingPanelControllerDelegate {
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            
            if let prevY = floatingPanelPreviousYPosition {
                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
            }
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
            vc.surfaceLocation = CGPoint(x: loc.x, y: max(loc.y, minY))
            floatingPanelPreviousYPosition = max(loc.y, minY)
        }
    }
    
    func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool) {
        if shouldDismissFloatingPanel {
            fpc.dismiss(animated: true, completion: nil)
        }
    }
}
