//
//  ImageCache.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let imageCache = NSCache<NSString, UIImage>()
    
    /// Store image
    func cache(_ image: UIImage, for key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    /// Fetch cached image
    func getImage(for key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
    /// Clears the entire cache
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
