//
//  SortCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

protocol SortCollectionDetailsViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String)
}

final class SortCollectionDetailsViewController: BaseViewController {
    
    weak var delegate: SortCollectionDetailsViewControllerDelegate?
    
    @IBOutlet var sortBtns: [UIButton]!
    
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        for (ind, val) in sortBtns.enumerated() {
            val.isSelected = ind == sender.tag
        }
        delegate?.selectionChanged(vc: self, sorting: CollectionsDetailsSettingsManager.shared.sortings[sender.tag])
    }
}
