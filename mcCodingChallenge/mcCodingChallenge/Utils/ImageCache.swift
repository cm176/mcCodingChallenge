//
//  ImageCache.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import UIKit

class ImageCache {
    
    // Create a shared instance of the cache
    static let shared = ImageCache()
    
    // Initialize the cache
    private let imageCache = NSCache<NSString, UIImage>()
    
    // Function to store an image in cache
    func cacheImage(image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    // Function to retrieve an image from cache
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
    // Function to clear cache
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
