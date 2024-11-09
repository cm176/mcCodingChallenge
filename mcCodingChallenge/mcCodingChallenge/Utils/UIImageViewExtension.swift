//
//  UIImageViewExtension.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import UIKit

extension UIImageView {
    func fetch(_ imageUrl: String) {
        if let cachedImage = ImageCache.shared.getImage(for: imageUrl) {
            // Use Cached Image
            self.image = cachedImage
        } else {
            // Fetch Image
            if let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    // Check for errors
                    guard let data = data, error == nil else {
                        print("Error loading image: \(String(describing: error))")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self?.image = image
                            ImageCache.shared.cache(image, for: imageUrl)
                        } else {
                            print("Failed to create image from data")
                        }
                    }
                }.resume() // Start the task
            }
        }
    }
}
