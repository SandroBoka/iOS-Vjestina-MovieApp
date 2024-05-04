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
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    imageView.image = UIImage(data: data)
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
        movieReleseDate.text = dateSplited[2] + "/" + dateSplited[1] + "/" + dateSplited[0] + " (US)"
        
        movieCategories.text = movieStruct.categories.map { String(describing: $0).capitalized }.joined(separator: ", ")
        
        let hours = Int(movieStruct.duration / 60)
        let minutes = movieStruct.duration % 60
        movieDuration.text = String(hours) + "h " + String(minutes) + "m"
        
        movieRating.textColor = .white
        movieRating.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        self.addSubview(movieRating)
        movieRating.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        movieRating.autoPinEdge(.top, to: .top, of: self, withOffset: 120)
        
        let userScoreLabel = UILabel()
        userScoreLabel.text = "User score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(userScoreLabel)
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: movieRating, withOffset: 10)
        userScoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: movieRating)
        userScoreLabel.autoPinEdge(.trailing, to: .trailing, of: self)
        
        movieName.textColor = .white
        movieName.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        self.addSubview(movieName)
        movieName.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        movieName.autoPinEdge(.top, to: .top, of: movieRating, withOffset: 50)
        
        movieYear.textColor = .white
        movieYear.font = UIFont.systemFont(ofSize: 22)
        self.addSubview(movieYear)
        movieYear.autoPinEdge(.leading, to: .trailing, of: movieName, withOffset: 5)
        movieYear.autoPinEdge(.top, to: .top, of: movieRating, withOffset: 50)
        movieYear.autoPinEdge(.trailing, to: .trailing, of: self)
        
        movieReleseDate.textColor = .white
        movieReleseDate.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(movieReleseDate)
        movieReleseDate.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        movieReleseDate.autoPinEdge(.top, to: .top, of: movieName, withOffset: 50)
        movieReleseDate.autoPinEdge(.trailing, to: .trailing, of: self)
        
        movieCategories.textColor = .white
        movieCategories.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(movieCategories)
        movieCategories.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        movieCategories.autoPinEdge(.top, to: .top, of: movieReleseDate, withOffset: 25)
        
        movieDuration.textColor = .white
        movieDuration.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        self.addSubview(movieDuration)
        movieDuration.autoPinEdge(.leading, to: .trailing, of: movieCategories, withOffset: 15)
        movieDuration.autoPinEdge(.top, to: .top, of: movieReleseDate, withOffset: 25)
        movieDuration.autoPinEdge(.trailing, to: .trailing, of: self)
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
