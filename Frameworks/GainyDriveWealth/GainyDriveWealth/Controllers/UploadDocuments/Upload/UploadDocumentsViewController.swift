//
//  UploadDocumentsViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 24.11.22.
//

import UIKit
import GainyCommon
import os.log

enum DocumentSides: String, CaseIterable {
    case frontSide = "Front side"
    case backSide = "Back side"
    case addFile = "Add file"
    
    static func getSides(for document: DocumentTypes) -> [DocumentSides] {
        switch document {
        case .driverLicense:
            return [.frontSide, .backSide]
        case .passport:
            return [.addFile]
        case .nationalIdCard:
            return [.frontSide, .backSide]
        case .votterId:
            return [.frontSide, .backSide]
        case .workPermit:
            return [.frontSide, .backSide]
        case .visa:
            return [.addFile]
        case .residencePermit:
            return [.frontSide, .backSide]
        }
    }
    
    var formSide: FormSide {
        switch self {
        case .frontSide:
            return .front
        case .backSide:
            return .back
        case .addFile:
            return .front
        }
    }
}

class UploadDocumentsViewController: DWBaseViewController {
    
    var documentType: DocumentTypes? {
        didSet {
            guard let documentType else { return }
            documentSides = DocumentSides.getSides(for: documentType)
        }
    }
    private var documentSides: [DocumentSides] = []
    private var uploadedDocuments: [DocumentSides] = []
    private var uploadedDocumentsImages: [UIImage] = []
    
    var dismissHandlerWithDocumentType: ((DocumentTypes?) -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.proDisplayBold(32)
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.font = UIFont.proDisplayMedium(16)
        }
    }
    
    @IBOutlet weak var bottomLabel: UILabel! {
        didSet {
            bottomLabel.font = UIFont.proDisplayMedium(16)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "UploadDocumentCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: UploadDocumentCell.reuseIdentifier)
            collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var uploadButton: GainyButton! {
        didSet {
            uploadButton.configureWithTitle(title: "Submit", color: .white, state: .normal)
            uploadButton.configureWithTitle(title: "Submit", color: .white, state: .disabled)
            uploadButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadedDocuments.publisher
            .receive(on: DispatchQueue.main)
            .count()
            .sink(receiveValue: { [weak self] count in
                guard let self = self else { return }
                if count > 0 {
                    UIView.animate(withDuration: 0.4) {
                        self.uploadButton.isEnabled = true
                    }
                } else {
                    UIView.animate(withDuration: 0.4) {
                        self.uploadButton.isEnabled = false
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    @IBAction func didTapUpload(_ sender: UIButton) {
        Task(priority: .userInitiated) {
            await uploadDocuments()
        }
    }
}

// MARK: - Functions
private extension UploadDocumentsViewController {
    func updateState() {
        if uploadedDocuments.count == documentSides.count {
            uploadButton.isEnabled = true
        } else {
            uploadButton.isEnabled = false
        }
    }
    
    func uploadDocuments() async {
        showNetworkLoader()
        guard let documentType else { return }
        for sideIndex in 0..<uploadedDocuments.count {
            do {
                let side = uploadedDocuments[sideIndex]
                guard let imageData = uploadedDocumentsImages[sideIndex].jpegData(compressionQuality: 1.0) else { return }
                let type = try await dwAPI.getUrlForDocument(contentType: "")
                guard let url = URL(string: type.url) else { return }
                var request = URLRequest(url: url)
                request.httpMethod = type.method
                let data = try await URLSession.shared.upload(for: request, from: imageData)
                guard let 
                try await dwAPI.kycSendUploadDocument(fileID: type.id, type: documentType.formType, side: side.formSide)
                dismissHandlerWithDocumentType?(documentType)
                navigationController?.popViewController(animated: true)
            }
            catch {
                hideLoader()
                print(error)
                os_log("@", error.localizedDescription)
                return
            }
        }
        hideLoader()
    }
}

// MARK: - UICollectionViewDataSource
extension UploadDocumentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentSides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = documentSides[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadDocumentCell.reuseIdentifier, for: indexPath) as? UploadDocumentCell else { return UICollectionViewCell() }
        cell.configure(title: item.rawValue, isUploaded: uploadedDocuments.contains(item))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension UploadDocumentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = documentSides[indexPath.row]
        if uploadedDocuments.contains(item) {
            return
        }
        ImagePickerManager.shared.presentImagePicker(self)
        ImagePickerManager.shared.imageCallback = { [weak self] image in
            guard let self = self else { return }
            self.uploadedDocuments.append(item)
            self.uploadedDocumentsImages.append(image)
            self.collectionView.reloadData()
            self.updateState()
        }
    }
}

// MARK: - CollectionView Layout
private extension UploadDocumentsViewController {
    func genereateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 32, leading: 32, bottom: 32, trailing: 32)
            section.interGroupSpacing = 16
            return section
        }
    }
}
