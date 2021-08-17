import Foundation
import UIKit

private enum CollectionDetailsSection: Int, CaseIterable {
    case collectionWithCards
}

final class CollectionDetailsViewController: BaseViewController, CollectionDetailsViewControllerProtocol {
    // MARK: Internal

    // MARK: Properties

    var viewModel: CollectionDetailsViewModelProtocol?

    var onDiscoverCollections: (() -> Void)?
    var onShowCardDetails: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Gainy.white

        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top + 20,
                width: view.bounds.width,
                height: 80
            )
        )
        navigationBarContainer.backgroundColor = UIColor.Gainy.white

        let discoverCollectionsButton = UIButton(
            frame: CGRect(
                x: navigationBarContainer.bounds.width - (32 + 20),
                y: 28,
                width: 32,
                height: 32
            )
        )

        discoverCollectionsButton.setImage(UIImage(named: "discover-collections"), for: .normal)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)

        navigationBarContainer.addSubview(discoverCollectionsButton)

        let searchTextView = UITextField(
            frame: CGRect(
                x: 16,
                y: 24,
                width: navigationBarContainer.bounds.width - (16 + 16 + 32 + 20),
                height: 40
            )
        )

        searchTextView.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextView.textColor = UIColor.Gainy.gray
        searchTextView.layer.cornerRadius = 16
        searchTextView.isUserInteractionEnabled = false

        let searchIconContainerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 14 + 24 + 6,
                height: 24
            )
        )

        let searchIconImageView = UIImageView(
            frame: CGRect(
                x: 14,
                y: 0,
                width: 24,
                height: 24
            )
        )

        searchIconContainerView.addSubview(searchIconImageView)

        searchIconImageView.contentMode = .center
        searchIconImageView.backgroundColor = UIColor.Gainy.lightBack
        searchIconImageView.image = UIImage(named: "search")

        searchTextView.leftView = searchIconContainerView
        searchTextView.leftViewMode = .always
        searchTextView.backgroundColor = UIColor.Gainy.lightBack

        navigationBarContainer.addSubview(searchTextView)

        view.addSubview(navigationBarContainer)

        let navigationBarTopOffset =
            navigationBarContainer.frame.origin.y + navigationBarContainer.bounds.height

        collectionDetailsCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: navigationBarTopOffset,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: customLayout
        )
        view.addSubview(collectionDetailsCollectionView)

        collectionDetailsCollectionView.register(CollectionDetailsViewCell.self)

        collectionDetailsCollectionView.backgroundColor = UIColor.Gainy.white
        collectionDetailsCollectionView.showsVerticalScrollIndicator = false
        collectionDetailsCollectionView.dragInteractionEnabled = true
        collectionDetailsCollectionView.bounces = false

        collectionDetailsCollectionView.dataSource = dataSource

        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>(
            collectionView: collectionDetailsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )

            if let cell = cell as? CollectionDetailsViewCell {
                cell.onCardPressed = { [weak self] in
                    self?.onShowCardDetails?()
                }
            }

            return cell
        }

        getRemoteData {
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()

                self?.centerInitialCollectionInTheCollectionView()
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private lazy var sections: [SectionLayout] = [
        HorizontalFlowSectionLayout(),
    ]

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()

    private var collectionDetailsCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, AnyHashable>()

    // MARK: Functions

    private func getRemoteData(completion: @escaping () -> Void) {
        showNetworkLoader()
        Network.shared.apollo.fetch(query: CollectionDetailsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.appCollections else {self?.hideLoader(); completion(); return;}
                DummyDataSource.remoteRawCollectionDetails = collections

                let yourCollectionDetails: [CollectionDetails] = DummyDataSource
                    .yourCollections
                    .compactMap { yourCollection in
                        CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(
                            DummyDataSource.remoteRawCollectionDetails.first(where: {
                                $0.id == yourCollection.id
                            })!
                        )
                    }

                let recommendedCollectionDetails: [CollectionDetails] = DummyDataSource
                    .recommendedCollections
                    .compactMap { recommendedCollection in
                        CollectionDetailsDTOMapper.mapAsCollectionFromRecommendedCollections(
                            DummyDataSource.remoteRawCollectionDetails.first(where: {
                                $0.id == recommendedCollection.id
                            })!
                        )
                    }

                DummyDataSource.collectionDetails.removeAll()
                DummyDataSource.collectionDetails.append(
                    contentsOf: yourCollectionDetails
                )

                DummyDataSource.collectionDetails.append(
                    contentsOf: recommendedCollectionDetails
                )

                self?.initViewModelsFromData()
                completion()

            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self?.initViewModelsFromData()
                completion()
            }
            self?.hideLoader()
        }
    }

    @objc
    private func discoverCollectionsButtonTapped() {
        onDiscoverCollections?()
    }

    // TODO: 1: implement class to have navBarContainer view
    private func createNavigationBarContainer() -> UIView {
        UIView()
    }

    private func centerInitialCollectionInTheCollectionView() {
        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0

        collectionDetailsCollectionView.scrollToItem(at: IndexPath(item: initialItemToShow, section: 0),
                                                     at: .centeredHorizontally,
                                                     animated: false)
    }

    private func initViewModelsFromData() {
        viewModel?.collectionDetails = DummyDataSource
            .collectionDetails
            .map { CollectionDetailsViewModelMapper.map($0) }
    }

    private func initViewModels() {
        snapshot.appendSections([.collectionWithCards])
        snapshot.appendItems(viewModel?.collectionDetails ?? [],
                             toSection: .collectionWithCards)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
