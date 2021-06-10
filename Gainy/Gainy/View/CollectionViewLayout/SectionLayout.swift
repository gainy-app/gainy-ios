import UIKit

protocol SectionLayout {
    func layoutSection(within environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection

    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       viewModel: AnyHashable,
                       position: Int) -> UICollectionViewCell
    func header(collectionView: UICollectionView,
                indexPath: IndexPath,
                viewModel: AnyHashable) -> UICollectionReusableView?
}

extension SectionLayout {
    func header(collectionView _: UICollectionView,
                indexPath _: IndexPath,
                viewModel _: AnyHashable) -> UICollectionReusableView? {
        nil
    }
}
