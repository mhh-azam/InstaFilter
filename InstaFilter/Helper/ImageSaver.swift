//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by QBUser on 08/07/22.
//

import Foundation
import UIKit

class ImageSaver: NSObject {

    var successHandler: (()->Void)?
    var errorHandler:((Error)->Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
    }

    @objc func saveComplete(_ image: UIImage, didFinisSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        }
        else {
            successHandler?()
        }
    }

}
