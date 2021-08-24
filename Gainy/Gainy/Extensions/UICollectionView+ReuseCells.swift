import UIKit

// swiftlint:disable force_cast

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let id = T.reuseIdentifier
        let cell = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! T
        return cell
    }
}

extension UICollectionViewCell {
    
    class var cellIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
