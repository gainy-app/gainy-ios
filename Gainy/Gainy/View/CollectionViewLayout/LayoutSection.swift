import UIKit

protocol LayoutSection {
    var layoutSection: NSCollectionLayoutSection { get }

    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       item: AnyHashable,
                       position: Int) -> UICollectionViewCell
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView?
}

extension LayoutSection {
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
         nil
    }
}
