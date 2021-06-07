import UIKit

extension UINavigationController {
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame = view
            .window?
            .windowScene?
            .statusBarManager?
            .statusBarFrame ?? .zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
