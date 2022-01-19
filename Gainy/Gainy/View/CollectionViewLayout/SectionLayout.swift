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
    func footer(collectionView: UICollectionView,
                indexPath: IndexPath) -> UICollectionReusableView?
}

extension SectionLayout {
    func header(collectionView _: UICollectionView,
                indexPath _: IndexPath,
                viewModel _: AnyHashable) -> UICollectionReusableView? {
        nil
    }
    
    func footer(collectionView: UICollectionView,
                indexPath: IndexPath) -> UICollectionReusableView? {
        nil
    }
}
