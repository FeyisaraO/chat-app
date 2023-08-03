//
//  UIImagePickerController.sourceType+Extension.swift
//  chat
//
//  Created by Feyisara Odukoya on 02/08/2023.
//

import Foundation
import UIKit

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
            case .camera:
                return 1
            case .photoLibrary:
                return 2
            case .savedPhotosAlbum:
                return 3
            @unknown default:
                return 4
        }
    }
}
