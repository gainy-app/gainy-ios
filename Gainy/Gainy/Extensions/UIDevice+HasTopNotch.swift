import UIKit

extension UIDevice {
    var hasTopNotch: Bool {
        let minimumTopInsetNotchDevicesHas: CGFloat = 20

        if let activeWindow = UIApplication.shared.windows.first {
            return activeWindow.safeAreaInsets.top > minimumTopInsetNotchDevicesHas
        }

        return false
    }
}
