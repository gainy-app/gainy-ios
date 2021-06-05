import Foundation
import UIKit

class DiscoverCardsViewController: UIViewController, DiscoverCardsViewControllerProtocol {
    // MARK: Internal

    // MARK: Types

    enum Section: Int, CaseIterable {
        case collectionsFlow
        case cards
    }

    // MARK: Properties

    var viewModel: DiscoverCardsViewModelProtocol?

    var onDiscoverCollections: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        discoverCardsCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: customLayout
        )
        view.addSubview(discoverCardsCollectionView)

        discoverCardsCollectionView.backgroundColor = UIColor.Gainy.yellow // TODO: change
        discoverCardsCollectionView.showsVerticalScrollIndicator = false
        discoverCardsCollectionView.dragInteractionEnabled = true

        discoverCardsCollectionView.dataSource = dataSource

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: discoverCardsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: modelItem,
                position: indexPath.row
            )

            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            return nil
        }

//        getRemoteData {
//            DispatchQueue.main.async { [weak self] in
//                self?.initViewModels()
//            }
//        }
    }

    // MARK: Private

    // MARK: Properties

    // Derives the order of the sections
    private lazy var sections: [SectionLayout] = [
    ]

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection
        }
        return layout
    }()

    private var discoverCardsCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
}
