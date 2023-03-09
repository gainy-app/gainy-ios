//
//  UploadDocumentsViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 24.11.22.
//

import UIKit
import GainyCommon
import os.log
import CoreServices
import PDFKit

enum DocumentSides: String, CaseIterable {
    case frontSide = "Front side"
    case backSide = "Back side"
    case addFile = "Add file"
    
    static func getSides(for document: DocumentTypes) -> [DocumentSides] {
        switch document {
        case .passport, .visa:
            return [.addFile]
        default:
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

enum DocumentType {
    case pdf
    case jpeg
    case png
    
    var contentType: String {
        switch self {
        case .pdf:
            return "application/pdf"
        case .jpeg:
            return "image/jpeg"
        case .png:
            return "image/png"
        }
    }
}

struct UploadDocumentDisplayModel {
    let documentSide: DocumentSides
    var document: Data?
    var displayImage: UIImage?
    var documentType: DocumentType?
    var isError = false
    
    mutating func setErrorState() {
        isError = true
        displayImage = nil
        documentType = nil
        document = nil
    }
}

class UploadDocumentsViewController: DWBaseViewController {
    
    var documentType: DocumentTypes? {
        didSet {
            guard let documentType else { return }
            documents = DocumentSides.getSides(for: documentType).map { UploadDocumentDisplayModel(documentSide: $0) }
        }
    }
    private var documents: [UploadDocumentDisplayModel] = []
    
    var dismissHandlerWithDocumentType: ((DocumentTypes?) -> Void)?
    let picker = FilesImagesPickerManager()
    
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
            uploadButton.configureWithTitle(title: "Upload", color: .white, state: .normal)
            uploadButton.configureWithTitle(title: "Upload", color: .white, state: .disabled)
            uploadButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let documentType else { return }
        subTitleLabel.text = documentType.description
        
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
        uploadButton.isEnabled = !documents.contains(where: { $0.document == nil })
    }
    
    func uploadDocuments() async {
        showNetworkLoader()
        guard let documentType else { return }
        for (index, document) in documents.enumerated() {
            do {
                let type = try await dwAPI.getUrlForDocument(contentType: document.documentType?.contentType ?? "")
                guard let url = URL(string: type.url) else { return }
                guard let data = document.document else { return }
                var request = URLRequest(url: url)
                request.httpMethod = type.method
                let requestData = try await URLSession.shared.upload(for: request, from: data)
                guard let response = requestData.1 as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    _ = try await dwAPI.kycSendUploadDocument(fileID: type.id, type: documentType.formType, side: document.documentSide.formSide)
                }
            } catch {
                documents[safe: index]?.setErrorState()
                hideLoader()
                let indexPath = IndexPath(row: index, section: 0)
                collectionView.reloadItems(at: [indexPath])
                os_log("@", error.localizedDescription)
                errorLabel.text = error.localizedDescription
                errorLabel.isHidden = false
                updateState()
                return
            }
        }
        hideLoader()
        dismissHandlerWithDocumentType?(documentType)
        navigationController?.popViewController(animated: true)
        self.GainyAnalytics.logEventAMP("dw_kyc_document_submitted")
    }
}

// MARK: - UICollectionViewDataSource
extension UploadDocumentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = documents[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadDocumentCell.reuseIdentifier, for: indexPath) as? UploadDocumentCell else { return UICollectionViewCell() }
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension UploadDocumentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if documents[indexPath.row].document != nil {
            return
        }
        errorLabel.isHidden = true
        picker.presentPicker(from: self)
        picker.fileUrlCallBack = { [weak self] url in
            guard let self else { return }
            if let document = PDFDocument(url: url) {
                self.documents[indexPath.row].document = document.dataRepresentation()
                self.documents[indexPath.row].displayImage = self.generateThumbnail(for: document, size: .init(width: self.view.frame.width - 64, height: 160))
                self.documents[indexPath.row].documentType = .pdf
                self.collectionView.reloadData()
                self.updateState()
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.documents[indexPath.row].displayImage = image
                self.documents[indexPath.row].document = image.jpegData(compressionQuality: 1.0)
                if url.absoluteString.contains(".png") {
                    self.documents[indexPath.row].documentType = .png
                } else {
                    self.documents[indexPath.row].documentType = .jpeg
                }
                self.collectionView.reloadData()
                self.updateState()
            }
            if self.documents[indexPath.row].isError {
                self.documents[indexPath.row].isError = false
                self.errorLabel.isHidden = true
                self.errorLabel.text = nil
            }
        }
        
        picker.imageCallback = { [weak self] image in
            guard let self else { return }
            self.documents[indexPath.row].displayImage = image
            self.documents[indexPath.row].document = image.jpegData(compressionQuality: 1.0)
            self.documents[indexPath.row].documentType = .jpeg
            if self.documents[indexPath.row].isError {
                self.documents[indexPath.row].isError = false
                self.errorLabel.isHidden = true
                self.errorLabel.text = nil
            }
            self.collectionView.reloadData()
            self.updateState()
        }
    }
    
    private func generateThumbnail(for document: PDFDocument, size: CGSize) -> UIImage? {
        let pdfDocumentPage = document.page(at: 1)
        return pdfDocumentPage?.thumbnail(of: size, for: .trimBox)
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
