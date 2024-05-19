//
//  MovieDeatilsHeaderView.swift
//  MovieApp
//
//  Created by Sandro Boka on 04.05.2024..
//

import Foundation
import UIKit
import PureLayout

class MovieDetailsHeaderView: UIView {
    
    var movieCategories = UILabel()
    
    init(movieStruct: Movie.MovieStruct) {
        super.init(frame: .zero)
        setup(movieStruct: movieStruct)
    }
    
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(movieStruct: Movie.MovieStruct) {
        getImage(movieStruct: movieStruct)
        
        buildImageLabels(movieStruct: movieStruct)
        
        buildButton()
    }
    
    
    private func getImage(movieStruct: Movie.MovieStruct) {
        let imageView = UIImageView()
        let url = URL(string: movieStruct.imageUrl)!
        let cacheKey = NSString(string: movieStruct.imageUrl) // Cache key
        
        // Check if the image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            imageView.image = cachedImage
        } else {
            // If not, download the image
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    // Cache the image
                    ImageCache.shared.setObject(image, forKey: cacheKey)
                    
                    // Update the image view on the main thread
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
        
        self.addSubview(imageView)
        let bounds = UIScreen.main.bounds
        let height = bounds.height * 0.4
        self.autoSetDimensions(to: CGSize(width: bounds.width, height: height))
        
        imageView.autoPinEdgesToSuperviewEdges()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    
    private func buildImageLabels(movieStruct: Movie.MovieStruct) {
        let movieRating = UILabel()
        let movieName = UILabel()
        let movieYear = UILabel()
        let movieReleseDate = UILabel()
        let movieDuration = UILabel()
        
        movieRating.text = String(movieStruct.rating)
        movieName.text = movieStruct.name
        movieYear.text = "(" + String(movieStruct.year) + ")"
        let dateSplited = movieStruct.releaseDate.split(separator: "-")
        movieReleseDate.text = "\(dateSplited[2])/\(dateSplited[1])/\(dateSplited[0]) (US)"
        
        movieCategories.text = movieStruct.categories.map { String(describing: $0).capitalized }.joined(separator: ", ")
        
        let hours = Int(movieStruct.duration / 60)
        let minutes = movieStruct.duration % 60
        movieDuration.text = "\(hours)h \(minutes)m"
        
        // Configure Labels
        [movieRating, movieName, movieYear, movieReleseDate, movieCategories, movieDuration].forEach {
            $0.textColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        movieRating.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        movieName.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        movieYear.font = UIFont.systemFont(ofSize: 22)
        movieReleseDate.font = UIFont.systemFont(ofSize: 16)
        movieCategories.font = UIFont.systemFont(ofSize: 16)
        movieDuration.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        
        let userScoreLabel = UILabel()
        userScoreLabel.text = "User score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userScoreLabel)
        
        // constraints
        NSLayoutConstraint.activate([
            movieRating.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            movieRating.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            
            userScoreLabel.leadingAnchor.constraint(equalTo: movieRating.trailingAnchor, constant: 10),
            userScoreLabel.centerYAnchor.constraint(equalTo: movieRating.centerYAnchor),
            
            movieName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            movieName.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 10),
            
            movieYear.leadingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 5),
            movieYear.centerYAnchor.constraint(equalTo: movieName.centerYAnchor),
            
            movieReleseDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            movieReleseDate.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            
            movieCategories.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            movieCategories.topAnchor.constraint(equalTo: movieReleseDate.bottomAnchor, constant: 10),
            
            movieDuration.leadingAnchor.constraint(equalTo: movieCategories.trailingAnchor, constant: 15),
            movieDuration.centerYAnchor.constraint(equalTo: movieCategories.centerYAnchor),
        ])
        
        // animations
        let labels = [movieRating, userScoreLabel, movieName, movieYear, movieReleseDate, movieCategories, movieDuration]
        
        self.layoutIfNeeded()
        
        for label in labels {
            label.transform = transform.translatedBy(x: -self.frame.width, y: 0)
        }
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.1,
            options: [.curveLinear],
            animations: {
                for label in labels {
                    label.transform = .identity
                }
            })
    }

    
    
    
    private func buildButton() {
        let emptyView = UIView()
        self.addSubview(emptyView)
        emptyView.autoPinEdge(.leading, to: .leading, of: self)
        emptyView.autoPinEdge(.trailing, to: .trailing, of: self)
        emptyView.autoPinEdge(.bottom, to: .bottom, of: self)
        emptyView.autoPinEdge(.top, to: .bottom, of: movieCategories, withOffset: 15)
        
        let button = UIButton(type: .custom)
        emptyView.addSubview(button)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.autoSetDimensions(to: CGSize(width: 35, height: 35))
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        button.autoPinEdge(.top, to: .top, of: emptyView)
    }
}
