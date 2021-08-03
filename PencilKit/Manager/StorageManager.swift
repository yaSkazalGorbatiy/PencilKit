//
//  dad.swift
//  PencilKit
//
//  Created by Сергей Горбачёв on 02.08.2021.
//

import UIKit
import PhotosUI

class StorageManager {
    
    func saveImage(canvasView: Canvas) {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)

        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if image != nil {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            } completionHandler: { (success, error) in
                if success {
                    print("Your image is saved")
                }
            }
        }
    }
}
