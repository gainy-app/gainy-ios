//
//  SingleCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.10.2021.
//

import UIKit

final class SingleCollectionDetailsViewController: BaseViewController {
    
    //MARK: - Outlets
    
    // MARK: Properties
    
   
    
    @IBOutlet private weak var collectionDetailsCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, AnyHashable>()
    
    //MARK: - DI
    var coordiantor: MainCoordinator?
    var collectionId: Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
