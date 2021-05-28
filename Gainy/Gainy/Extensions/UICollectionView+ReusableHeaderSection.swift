import UIKit

// swiftlint:disable force_cast

extension UICollectionView {
    func registerSectionHeader<T: UICollectionReusableView>(_: T.Type) {
        self.register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func dequeueReusableSectionHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        self.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T
    }
}
