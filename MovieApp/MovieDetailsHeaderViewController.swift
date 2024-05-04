//
//  MovieDetailsHeaderViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 04.05.2024..
//

import Foundation
import UIKit

class MovieDetailsHeaderView: UIView {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func buildImage() {
        let imageView = UIImageView()
        if let imageUrl = movie.imageUrl {
            let url = URL(string: imageUrl)!
            
            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
}
