//
//  ImagePickerManager.swift
//  THGCEM
//
//  Created by Nirav Jariwala on 04/01/19.
//  Copyright © 2019 Nirav Jariwala. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

protocol ImagePickerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingWithImage image: UIImage)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingWithVideo videoData: Data, videoURL: URL, thumbmailImage: UIImage)
    func imagePickerController(_ picker: UIImagePickerController, didFailWithError error: String)
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
}

extension ImagePickerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingWithVideo videoData: Data, videoURL: URL, thumbmailImage: UIImage) {
        
    }
}

class ImagePickerManager: NSObject {
    
    static let shared = ImagePickerManager()
    var imagePickerDelegate: ImagePickerDelegate?
    
    func imagePickerController(withSourceType sourceType: UIImagePickerController.SourceType, mediaTypes: [String]) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = mediaTypes
        imagePicker.delegate = self
        return imagePicker
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String ?? ""
        if mediaType == kUTTypeImage as String {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.imagePickerDelegate?.imagePickerController(picker, didFinishPickingWithImage: image)
            }
        }
        else if let url = info[UIImagePickerController.InfoKey.mediaURL]as? URL {
            if let videoData = try? Data(contentsOf: url, options: .mappedIfSafe), videoData.size < 10 {
                do {
                    let asset = AVURLAsset(url: url , options: nil)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                    imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                    let thumbnail = UIImage(cgImage: cgImage)
                    self.imagePickerDelegate?.imagePickerController(picker, didFinishPickingWithVideo: videoData, videoURL: url, thumbmailImage: thumbnail)
                } catch let error {
                    self.imagePickerDelegate?.imagePickerController(picker, didFailWithError: error.localizedDescription)
                }
            }
            else {
                self.imagePickerDelegate?.imagePickerController(picker, didFailWithError: "File is too big. Maximum allowed size 10 MB.")
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerDelegate?.imagePickerControllerDidCancel(picker)
    }
}
