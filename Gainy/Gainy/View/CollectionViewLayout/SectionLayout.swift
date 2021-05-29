import UIKit

protocol SectionLayout {
    var layoutSection: NSCollectionLayoutSection { get }

    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       item: AnyHashable,
                       position: Int) -> UICollectionViewCell
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView?
}

extension SectionLayout {
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
         nil
    }
}
