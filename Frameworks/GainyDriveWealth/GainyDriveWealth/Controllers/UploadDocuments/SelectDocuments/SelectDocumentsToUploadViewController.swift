//
//  SelectDocumentsToUploadViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 23.11.22.
//

import UIKit
import GainyCommon
import GainyAPI
import os.log

enum DocumentTypes: String, CaseIterable {
    case driverLicense = "Driver’s License"
    case passport = "Passport"
    case nationalIdCard = "National ID card"
    case votterId = "Votter ID"
    case workPermit = "Work Permit"
    case visa = "Visa"
    case residencePermit = "Residence Permit"
    
    var formType: FormType {
        switch self {
        case .driverLicense:
            return .driverLicense
        case .passport:
            return .passport
        case .nationalIdCard:
            return .nationalID
        case .votterId:
            return .voterID
        case .workPermit:
            return .workPermit
        case .visa:
            return .visa
        case .residencePermit:
            return .residencePermit
        }
    }
    
    var description: String {
        switch self {
        case .passport, .visa:
            return "Please upload photos of your \(self.rawValue), just front. No cutting corners please."
        default:
            return "Please upload photos of your \(self.rawValue), front and back. No cutting corners please."
        }
    }
}

class SelectDocumentsToUploadViewController: DWBaseViewController {
    
    private var documentTypes: [DocumentTypes] = DocumentTypes.allCases
    private var selectedDocumentsTypes: [DocumentTypes] = []
    private var presignedForm: GetUrlForDocumentMutation.Data.GetPreSignedUploadForm?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.proDisplayBold(32)
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.font = UIFont.proDisplaySemibold(16)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
            collectionView.reloadData()
            collectionView.register(UINib(nibName: "SelectDocumentCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: SelectDocumentCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var uploadButton: GainyButton! {
        didSet {
            uploadButton.configureWithTitle(title: "Submit", color: .white, state: .normal)
            uploadButton.configureWithTitle(title: "Submit", color: .white, state: .disabled)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDocumentsTypes.publisher
            .receive(on: DispatchQueue.main)
            .count()
            .sink(receiveValue: { [weak self] count in
                if count > 0 {
                    self?.uploadButton.isEnabled = true
                } else {
                    self?.uploadButton.isEnabled = false
                }
            })
            .store(in: &cancellables)
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        showNetworkLoader()
        Task(priority: .userInitiated) {
            do {
                try await dwAPI.kycSendForm()
                hideLoader()
                navigationController?.dismiss(animated: true)
            } catch {
                hideLoader()
                os_log("@", error.localizedDescription)
            }
        }
    }
}

extension SelectDocumentsToUploadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = documentTypes[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectDocumentCell.reuseIdentifier, for: indexPath) as? SelectDocumentCell else { return UICollectionViewCell() }
        cell.configure(title: item.rawValue, state: selectedDocumentsTypes.contains(item))
        return cell
    }
}

extension SelectDocumentsToUploadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = documentTypes[indexPath.row]
        coordinator?.showUploadDocuments(with: type) { [weak self] type in
            guard let type else { return }
            self?.selectedDocumentsTypes.append(type)
            self?.collectionView.reloadData()
            self?.updateState()
        }
    }
}

private extension SelectDocumentsToUploadViewController {
    func updateState() {
        if selectedDocumentsTypes.count > 0 {
            uploadButton.isEnabled = true
        } else {
            uploadButton.isEnabled = false
        }
    }
    
    func filterDocumentTypes() {
        documentTypes = documentTypes.filter { !selectedDocumentsTypes.contains($0) }
        collectionView.reloadData()
    }
    
    func genereateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 24, leading: 32, bottom: 56, trailing: 32)
            section.interGroupSpacing = 8
            return section
        }
    }
}
