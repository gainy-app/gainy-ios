//
//  LinkProfileAccountViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.05.2023.
//
import UIKit
import Combine

final class LinkProfileAccountViewController: BaseViewController {
    
    weak var mainCoordinator: MainCoordinator?
    
    let choicePublisher = PassthroughSubject<Bool, Never>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func letsGoAction(_ sender: Any) {
        delay(0.3) {
            self.mainCoordinator?.dwShowDeposit(from: self.presentingViewController)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func noAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
