//
//  ImageCache.swift
//  MovieApp
//
//  Created by Sandro Boka on 18.05.2024..
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
