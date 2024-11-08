//
//  ImageCacheTests.swift
//  mcCodingChallengeTests
//
//  Created by Gloomy on 8/11/2024.
//

import XCTest
@testable import mcCodingChallenge

final class ImageCacheTests: XCTestCase {
    var imageCache: ImageCache!

    override func setUpWithError() throws {
        imageCache = ImageCache()
    }

    override func tearDownWithError() throws {
        imageCache.clearCache()
        imageCache = nil
    }
    
    /// Test storing then retreiving a test image
    func testStoreAndRetrieveImage() {
        let image = UIImage(named: "testImage1")!
        let key = "image1"
        
        imageCache.cache(image, for: key)
        
        if let retrievedImage = imageCache.getImage(for: key) {
            XCTAssertEqual(retrievedImage, image)
        } else {
            XCTFail("The image should be retrieved successfully from the cache.")
        }
    }
    
    /// Test clearing the cache
    func testClearCache() {
        let image1 = UIImage(named: "testImage1")!
        let image2 = UIImage(named: "testImage2")!
        
        imageCache.cache(image1, for: "image1")
        imageCache.cache(image2, for: "image2")
        
        imageCache.clearCache()
        
        XCTAssertNil(imageCache.getImage(for: "image1"))
        XCTAssertNil(imageCache.getImage(for: "image2"))
    }
}
