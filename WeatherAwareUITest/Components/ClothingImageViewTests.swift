//  ClothingImageViewTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import UIKit
@testable import WeatherAware

final class ClothingImageViewTests: XCTestCase {
    
    func testImageData_decodesToUIImage() {
        // Given: valid image data
        let sampleImage = UIImage(systemName: "tshirt")!
        let imageData = sampleImage.pngData()
        
        // When: decoding image data
        let decodedImage = imageData.flatMap { UIImage(data: $0) }
        
        // Then: image should not be nil
        XCTAssertNotNil(decodedImage, "UIImage should be created from valid data")
    }
    
    func testImageData_nilReturnsNil() {
        // Given: nil image data
        let imageData: Data? = nil
        
        // When: decoding image data
        let decodedImage = imageData.flatMap { UIImage(data: $0) }
        
        // Then: result should be nil
        XCTAssertNil(decodedImage, "UIImage should be nil when imageData is nil")
    }
    
    func testPlaceholderImageUsed_whenDataIsNil() {
        // Given: ClothingImageView with nil data
        let placeholderName = "tshirt"
        let imageData: Data? = nil
        
        // Simulate what the view does:
        let finalImage: UIImage?
        if let data = imageData, let uiImage = UIImage(data: data) {
            finalImage = uiImage
        } else {
            finalImage = UIImage(systemName: placeholderName)
        }
        
        // Then: placeholder image should be used
        XCTAssertNotNil(finalImage, "Placeholder image should be used when data is nil")
    }
    
    func testPlaceholderImageNotUsed_whenDataIsValid() {
        // Given: valid image data
        let sampleImage = UIImage(systemName: "tshirt")!
        let imageData = sampleImage.pngData()
        
        // Simulate what the view does:
        let finalImage: UIImage?
        if let data = imageData, let uiImage = UIImage(data: data) {
            finalImage = uiImage
        } else {
            finalImage = UIImage(systemName: "tshirt")
        }
        
        // Then: final image should not be the placeholder
        XCTAssertNotNil(finalImage)
        XCTAssertFalse(finalImage === UIImage(systemName: "tshirt"),
                       "Should use decoded image, not placeholder")
    }
}
