//
//  FilesImagesPickerManager.swift
//  GainyCommon
//
//  Created by Евгений Таран on 1.12.22.
//

import UIKit
import AVFoundation
import CoreServices

public class FilesImagesPickerManager: NSObject {

    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String, kUTTypePNG as String, kUTTypeJPEG as String], in: .open)
    
    public var imageCallback: ((UIImage) -> Void)?
    public var fileUrlCallBack: ((URL) -> Void)?
    public func presentPicker(from controller: UIViewController) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("Choose photo source", comment: ""), preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        func showPicker() {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.modalPresentationStyle = .fullScreen
            controller.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let photoButton = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default) {(action) in
                let authStatus = AVCaptureDevice.authorizationStatus(for: .video)

                if authStatus == AVAuthorizationStatus.denied {
                    // Denied access to camera
                    // Explain that we need camera access and how to change it.
                    let dialog = UIAlertController(title: NSLocalizedString("Unable to access the Camera", comment: ""),
                                                   message: NSLocalizedString("To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app", comment: ""), preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.cancel, handler: nil)
                    let settingsAction = UIAlertAction(title: NSLocalizedString("settings", comment: ""), style: UIAlertAction.Style.default, handler: {action in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            })
                        }
                    })
                    dialog.addAction(okAction)
                    dialog.addAction(settingsAction)
                    controller.present(dialog, animated:true, completion:nil)

                } else if authStatus == AVAuthorizationStatus.notDetermined {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (grantd) in
                       if grantd {
                        DispatchQueue.main.async {
                            showPicker()
                        }
                            
                        }
                    })
                } else {
                    // Allowed access to camera, go ahead and present the UIImagePickerController.
                    DispatchQueue.main.async {
                        showPicker()
                    }
                }
        }
        
        let libraryButton = UIAlertAction(title: NSLocalizedString("Select from Library", comment: ""), style: .default) {[unowned self] (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.modalPresentationStyle = .fullScreen
            controller.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let filesAction = UIAlertAction(title: NSLocalizedString("Select from Files", comment: ""), style: .default) { [unowned self] (action) in
            self.documentPicker.delegate = self
            self.documentPicker.allowsMultipleSelection = false
            self.documentPicker.modalPresentationStyle = .fullScreen
            self.documentPicker.shouldShowFileExtensions = true
            controller.present(self.documentPicker, animated: true)
        }
        
        alertController.addAction(photoButton)
        alertController.addAction(libraryButton)
        alertController.addAction(filesAction)
        
        controller.present(alertController, animated: true) {
        }
    }
}

extension FilesImagesPickerManager: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        documentPicker.dismiss(animated: true)
        guard url.startAccessingSecurityScopedResource() else {
            return
        }
        fileUrlCallBack?(url)
        url.stopAccessingSecurityScopedResource()
    }
}

extension FilesImagesPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageCallback?(image.fixedOrientation() ?? UIImage())
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


