import UIKit

// TODO: move into a separate file
protocol CardDetailsViewModelProtocol {
//    var initialCollectionIndex: Int { get set }
//    var collectionDetails: [CollectionDetailViewCellModel] { get set }
}

final class CardDetailsViewModel: NSObject, CardDetailsViewModelProtocol {
//    var initialCollectionIndex = 0
//    var collectionDetails = [CollectionDetailViewCellModel]()
}

private enum CardDetailsSection: Int, CaseIterable {
    case highlights
    case marketData
}

final class CardDetailsViewController: UIViewController, CardDetailsViewControllerProtocol {
    // MARK: Internal

    // MARK: Properties

    var viewModel: CardDetailsViewModel?

    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Gainy.white

        containerCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 20,
                width: view.bounds.width,
                height: view.bounds.height - 60 - 20
            ),
            collectionViewLayout: customLayout
        )
        containerCollectionView.backgroundColor = .red
        view.addSubview(containerCollectionView)

        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top,
                width: view.bounds.width,
                height: 80
            )
        )
        navigationBarContainer.backgroundColor = UIColor.Gainy.textDark

//        let companyNameLabel = UILabel(
//            frame: CGRect.zero
//        )
//        let tickerSymbol = UILabel(
//            frame: CGRect.zero
//        )

//        containerCollectionView.addSubview(navigationBarContainer)

        containerCollectionView.registerSectionHeader(HighlightHeaderView.self)
        containerCollectionView.register(HightlightViewCell.self)

        containerCollectionView.backgroundColor = UIColor.Gainy.white
        containerCollectionView.showsVerticalScrollIndicator = false
        containerCollectionView.dragInteractionEnabled = true
        containerCollectionView.bounces = false

        containerCollectionView.dataSource = dataSource

        let mockImageGraphView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 80,
                width: view.bounds.width,
                height: view.bounds.width / 1.2886
            )
        )
        mockImageGraphView.image = UIImage(named: "graph-mocked")
//        containerCollectionView.addSubview(mockImageGraphView)

        dataSource = UICollectionViewDiffableDataSource<CardDetailsSection, AnyHashable>(
            collectionView: containerCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )

//            if let cell = cell as? HightlightViewCell {
//                cell.onCardPressed = { [weak self] in
//                    self?.onShowCardDetails?()
//                }
//            }

            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerViewModel = CollectionHeaderViewModel(title: "a", description: "b")

//                let headerViewModel = indexPath.section == CardDetailsSection.highlights.rawValue
//                    ? HighlightHeaderView(
//                        title: "Highlights"
//                    )
//                    : HighlightHeaderView(
//                        title: "Market data"
//                    )

                return self?.sections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath,
                    viewModel: headerViewModel
                )
            default:
                return nil
            }
        }

        initViewModels()
    }

    // MARK: Private

    // MARK: Properties

    private lazy var sections: [SectionLayout] = [
        HightlightsHorizontalSectionLayout(),
        MarketDataHorizontalSectionLayout(),
    ]

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()

    private var containerCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<CardDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CardDetailsSection, AnyHashable>()

    // MARK: - Functions

    private func initViewModels() {
        snapshot.appendSections([.highlights, .marketData])
        snapshot.appendItems([1,2,3], toSection: .highlights)
        snapshot.appendItems([4,5,6,7,8], toSection: .marketData)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
