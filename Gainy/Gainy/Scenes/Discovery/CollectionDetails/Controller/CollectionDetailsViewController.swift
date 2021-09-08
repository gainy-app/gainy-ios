import Foundation
import UIKit
import PureLayout
import FloatingPanel

private enum CollectionDetailsSection: Int, CaseIterable {
    case collectionWithCards
}

final class CollectionDetailsViewController: BaseViewController, CollectionDetailsViewControllerProtocol {    
    // MARK: Internal

    // MARK: Properties

    var viewModel: CollectionDetailsViewModelProtocol?

    var onDiscoverCollections: (() -> Void)?
    var onShowCardDetails: ((DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker) -> Void)?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0

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
        discoverCollectionsBtn = discoverCollectionsButton
        let searchTextView = UITextField(
            frame: CGRect(
                x: 16,
                y: 24,
                width: navigationBarContainer.bounds.width - (16 + 16 + 32 + 20),
                height: 40
            )
        )

        searchTextView.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextView.textColor = UIColor(named: "mainText")
        searchTextView.layer.cornerRadius = 16
        searchTextView.isUserInteractionEnabled = true
        searchTextView.clearButtonMode = .always
        searchTextView.clearButtonMode = .whileEditing
        searchTextView.placeholder = "Search anything"
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
        searchTextView.rightViewMode = .whileEditing
        searchTextView.backgroundColor = UIColor.Gainy.lightBack
        
        
        let btnFrame = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24 + 12, height: 24))
        let clearBtn = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 24,
                height: 24
            )
        )
        clearBtn.setImage(UIImage(named: "search_clear"), for: .normal)
        clearBtn.addTarget(self, action: #selector(textFieldClear), for: .touchUpInside)
        btnFrame.addSubview(clearBtn)
        searchTextView.rightView = btnFrame
        
        searchTextView.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        searchTextView.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        searchTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextView.delegate = self
        navigationBarContainer.addSubview(searchTextView)
        self.searchTextView = searchTextView
        
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
        collectionDetailsCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        collectionDetailsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        collectionDetailsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        collectionDetailsCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)

        collectionDetailsCollectionView.register(CollectionDetailsViewCell.self)

        collectionDetailsCollectionView.backgroundColor = .clear
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
                if let model = modelItem as? CollectionDetailViewCellModel {
                    cell.tag = model.id
                }
                cell.onCardPressed = {[weak self]  ticker in
                    self?.onShowCardDetails?(ticker)
                }
                cell.onSortingPressed = { [weak self] in
                    guard let self = self else {return}
                    guard self.presentedViewController == nil else {return}
                    self.present(self.fpc, animated: true, completion: nil)
                    if let model = modelItem as? CollectionDetailViewCellModel {
                        self.currentCollectionToChange = model.id
                        GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : model.id])
                    }
                }
            }

            return cell
        }
        
        searchCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: navigationBarTopOffset,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: CollectionSearchController.createLayout([.loader])
        )
        view.addSubview(searchCollectionView)
        searchCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        searchCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        searchCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        searchCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)

        searchCollectionView.backgroundColor = .clear
        searchCollectionView.showsVerticalScrollIndicator = false
        searchCollectionView.dragInteractionEnabled = true
        searchCollectionView.bounces = false
        searchCollectionView.alpha = 0.0
        searchController = CollectionSearchController.init(collectionView: searchCollectionView, callback: {[weak self] ticker in
            self?.onShowCardDetails?(ticker)
        })
        getRemoteData {
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()

                self?.centerInitialCollectionInTheCollectionView()
            }
        }
        setupPanel()
    }
    
    @objc func textFieldClear() {
        searchTextView?.text = ""
        searchController?.searchText = searchTextView?.text ?? ""
        searchController?.clearAll()
        
        let oldFrame = CGRect(
            x: 16,
            y: 24,
            width: self.view.bounds.width - (16 + 16 + 32 + 20),
            height: 40
        )
        UIView.animate(withDuration: 0.3) {
            self.collectionDetailsCollectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.discoverCollectionsBtn?.alpha = 1.0
            self.searchTextView?.frame = oldFrame
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard (textField.text ?? "").count > 2 else {return}
        searchController?.searchText = textField.text ?? ""
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_started")
        UIView.animate(withDuration: 0.3) {
            self.collectionDetailsCollectionView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.discoverCollectionsBtn?.alpha = 0.0
            self.searchTextView?.frame = CGRect(
                x: 16,
                y: 24,
                width: self.view.bounds.width - (16 + 16),
                height: 40
            )
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_ended")
//        let oldFrame = CGRect(
//            x: 16,
//            y: 24,
//            width: self.view.bounds.width - (16 + 16 + 32 + 20),
//            height: 40
//        )
//        UIView.animate(withDuration: 0.3) {
//            self.collectionDetailsCollectionView.alpha = 1.0
//            self.searchCollectionView.alpha = 0.0
//            self.discoverCollectionsBtn?.alpha = 1.0
//            self.searchTextView?.frame = oldFrame
//        }
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
    private var searchCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, AnyHashable>()
    
    private var searchController: CollectionSearchController?
    private var discoverCollectionsBtn: UIButton?
    private var searchTextView: UITextField?
    
    // MARK: Functions

    private func getRemoteData(completion: @escaping () -> Void) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        guard !isNetworkLoading else {
            return
        }
        showNetworkLoader()
        Network.shared.apollo.fetch(query: DiscoverCollectionDetailsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.collections else {
                    //Going back                    
                    //self?.onDiscoverCollections?()
                    self?.hideLoader()
                    completion()
                    return
                }
                DummyDataSource.remoteRawCollectionDetails = collections.sorted(by: {$0.tickerCollectionsAggregate.aggregate?.count ?? 0 > $1.tickerCollectionsAggregate.aggregate?.count ?? 0})

                //Fetching Tickers prices
                var tickerSymbols: [String] = []
                DummyDataSource.remoteRawCollectionDetails.forEach({
                    tickerSymbols.append(contentsOf: $0.tickerCollections.compactMap({$0.ticker?.symbol}))
                })
                TickersLiveFetcher.shared.getSymbolsData(tickerSymbols) {
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
                        contentsOf: DummyDataSource.remoteRawCollectionDetails.compactMap( {
                            CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections($0)
                        })
                    )

    //                DummyDataSource.collectionDetails.append(
    //                    contentsOf: recommendedCollectionDetails
    //                )

                    self?.initViewModelsFromData()
                    completion()
                }
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
        GainyAnalytics.logEvent("discover_collections_pressed")
        onDiscoverCollections?()
    }

    // TODO: 1: implement class to have navBarContainer view
    private func createNavigationBarContainer() -> UIView {
        UIView()
    }

    func centerInitialCollectionInTheCollectionView() {
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
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.layout = MyFloatingPanelLayout()
        let appearance = SurfaceAppearance()

        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Assign self as the delegate of the controller.
        //fpc.delegate = self // Optional
        
        // Set a content view controller.
        let contentVC = SortCollectionDetailsViewController.instantiate(.popups)
        contentVC.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.isRemovalInteractionEnabled = true
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        //fpc.addPanel(toParent: self)
    }
    
    class MyFloatingPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .top, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCollectionsIfNoneExists()
    }
    
    fileprivate func loadCollectionsIfNoneExists() {
        if DummyDataSource.collectionDetails.count == 0 {
            getRemoteData {
                DispatchQueue.main.async { [weak self] in
                    self?.initViewModels()

                    self?.centerInitialCollectionInTheCollectionView()
                }
            }
        }
    }
    
    //MARK: - Swap Items
    
    func swapItemsAt(_ sourceInd: Int, destInd: Int) {
        guard var snapshot = dataSource?.snapshot() else {return}        
        
        guard let sourceItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
            if let model = anyHashable as? CollectionDetailViewCellModel {
                return model.id == sourceInd
            }
            return false
        }) else {return}
        
        guard let destItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
        if let model = anyHashable as? CollectionDetailViewCellModel {
            return model.id == destInd
        }
        return false
        }) else {return}
        
        snapshot.moveItem(sourceItem, beforeItem: destItem)
        dataSource?.apply(snapshot)
    }
    
    //MARK: - Delete Items
    
    func deleteItem(_ sourceInd: Int) {
        guard var snapshot = dataSource?.snapshot() else {return}
        if let sourceItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
            if let model = anyHashable as? CollectionDetailViewCellModel {
                return model.id == sourceInd
            }
            return false
        }) {
            snapshot.deleteItems([sourceItem])
            dataSource?.apply(snapshot)
        }
        
    }
}

extension CollectionDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CollectionDetailsViewController: SortCollectionDetailsViewControllerDelegate {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String) {
        GainyAnalytics.logEvent("sorting_changed", params: ["collectionID": currentCollectionToChange, "sorting" : sorting])
        self.fpc.dismiss(animated: true, completion: nil)
    }
}
