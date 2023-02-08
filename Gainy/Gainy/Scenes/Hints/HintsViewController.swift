//
//  HintsViewController.swift
//  Gainy
//
//  Created by r10 on 06.02.2023.
//

import UIKit
import GainyCommon

struct HintCellModel {
    let title: String
    let subtitle: String?
    let coverImage: UIImage
    let mainImage: UIImage
}
 

class HintsViewController: BaseViewController {
    
    // MARK: - Private properties
    private var cellModels: [HintCellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: GainyPageControl!
    @IBOutlet private weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 16
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - IBActions
    @IBAction func didTapNext(_ sender: UIButton) {
        guard let visibleCells = collectionView.indexPathsForVisibleItems.first else { return }
        if visibleCells.row != (cellModels.count - 1) {
            collectionView.scrollToItem(at: .init(row: visibleCells.row + 1, section: visibleCells.section), at: .left, animated: true)
        } else {
            if let nav = navigationController {
                nav.popViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        }
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismissHandler?()
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HintsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cellModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.reuseIdentifier, for: indexPath) as? HintCell else { return UICollectionViewCell() }
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (cellModels.count - 1) {
            nextButton.setTitle("Done", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HintsViewController: UICollectionViewDelegate {
    
}

private extension HintsViewController {
    func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HintCell.nib, forCellWithReuseIdentifier: HintCell.reuseIdentifier)
    }
}
