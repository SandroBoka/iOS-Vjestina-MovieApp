//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 30.03.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieDetailsViewController: UIViewController {
    
    var imageView: UIImageView!
    var whiteRectangle: UIView!
    var stackView: UIStackView!
    var movieRating: UILabel!
    var movieName: UILabel!
    var movieYear: UILabel!
    var movieReleseDate: UILabel!
    var movieDuration: UILabel!
    var movieCategories: UILabel!
    var movieSummary: UILabel!
    var movieCrewMembers: UILabel!
    
    var movie = Movie(movieId: 111161)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
    }
    
    private func buildImage(){
        // Fetch and set image
        let bounds = UIScreen.main.bounds
        let height = bounds.height * 0.4
        imageView = UIImageView()
        imageView.autoSetDimensions(to: CGSize(width: bounds.width, height: height))
        if let imageUrl = movie.imageUrl {
            let url = URL(string: imageUrl)!
            
            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.autoPinEdge(toSuperviewEdge: .leading)
        imageView.autoPinEdge(toSuperviewEdge: .top)
    }
    
    
    private func buildRectangle() {
        whiteRectangle = UIView()
        whiteRectangle.backgroundColor = .white
        view.addSubview(whiteRectangle)
        whiteRectangle.autoPinEdge(.top, to: .bottom, of: imageView)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .leading)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .bottom)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    
    private func buildImageLabels() {
        movieRating = UILabel()
        movieName = UILabel()
        movieYear = UILabel()
        movieReleseDate = UILabel()
        movieCategories = UILabel()
        movieDuration = UILabel()
        
        if let name = movie.name, let releaseDay = movie.releaseDate, let year = movie.year, let duration = movie.duration,
            let rating = movie.rating, let categories = movie.categories
        {
            movieRating.text = String(rating)
            movieName.text = name
            movieYear.text = "(" + String(year) + ")"
            let helping = releaseDay.split(separator: "-")
            movieReleseDate.text = helping[2] + "/" + helping[1] + "/" + helping[0] + " (US)"
            
            var helping2 = ""
            for index in 0 ..< categories.count {
                helping2 += (String(describing: categories[index]).capitalized)
                if index < categories.count - 1 {
                    helping2 += ", "
                }
            }
            movieCategories.text = helping2
            
            let hours = Int(duration / 60)
            let minutes = duration % 60
            movieDuration.text = String(hours) + "h " + String(minutes) + "m"
        }
        
        movieRating.textColor = .white
        movieRating.font = UIFont.boldSystemFont(ofSize: 20)
        imageView.addSubview(movieRating)
        movieRating.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieRating.autoPinEdge(.top, to: .top, of: imageView, withOffset: 120)
        
        let label1 = UILabel()
        label1.text = "User score"
        label1.textColor = .white
        label1.font = UIFont.systemFont(ofSize: 18)
        imageView.addSubview(label1)
        label1.autoPinEdge(.leading, to: .trailing, of: movieRating, withOffset: 10)
        label1.autoAlignAxis(.horizontal, toSameAxisOf: movieRating)
        
        movieName.textColor = .white
        movieName.font = UIFont.boldSystemFont(ofSize: 23)
        imageView.addSubview(movieName)
        movieName.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieName.autoPinEdge(.top, to: .top, of: imageView, withOffset: 170)
        
        movieYear.textColor = .white
        movieYear.font = UIFont.systemFont(ofSize: 23)
        imageView.addSubview(movieYear)
        movieYear.autoPinEdge(.leading, to: .trailing, of: movieName, withOffset: 10)
        movieYear.autoPinEdge(.top, to: .top, of: imageView, withOffset: 170)
        
        movieReleseDate.textColor = .white
        movieReleseDate.font = UIFont.systemFont(ofSize: 17)
        imageView.addSubview(movieReleseDate)
        movieReleseDate.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieReleseDate.autoPinEdge(.top, to: .top, of: imageView, withOffset: 220)
        
        movieCategories.textColor = .white
        movieCategories.font = UIFont.systemFont(ofSize: 17)
        imageView.addSubview(movieCategories)
        movieCategories.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 14)
        movieCategories.autoPinEdge(.top, to: .top, of: imageView, withOffset: 245)
        
        movieDuration.textColor = .white
        movieDuration.font = UIFont.boldSystemFont(ofSize: 17)
        imageView.addSubview(movieDuration)
        movieDuration.autoPinEdge(.leading, to: .trailing, of: movieCategories, withOffset: 15)
        movieDuration.autoPinEdge(.top, to: .top, of: imageView, withOffset: 245)
    }
    
    
    private func buildButton() {
        let button = UIButton(type: .custom)
        imageView.addSubview(button)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.autoSetDimensions(to: CGSize(width: 35, height: 35))
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        button.autoPinEdge(.top, to: .top, of: imageView, withOffset: 280)
    }
    
    private func buildRectangleLabels() {
        movieSummary = UILabel()
        
        if let summary = movie.summary, let crewMembers = movie.crewMembers
        {
            movieSummary.text = summary
        }
        
        var label2 = UILabel()
        label2.textColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1.0)
        label2.text = "Overview"
        label2.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        whiteRectangle.addSubview(label2)
        label2.autoPinEdge(.leading, to: .leading, of: whiteRectangle, withOffset: 15)
        label2.autoPinEdge(.top, to: .top, of: whiteRectangle, withOffset: 30)
        
        movieSummary.font = UIFont.systemFont(ofSize: 15)
        movieSummary.translatesAutoresizingMaskIntoConstraints = false
        movieSummary.numberOfLines = 0
        whiteRectangle.addSubview(movieSummary)
        movieSummary.autoPinEdge(.leading, to: .leading, of: whiteRectangle, withOffset: 15)
        movieSummary.autoPinEdge(.top, to: .top, of: whiteRectangle, withOffset: 70)
        movieSummary.autoPinEdge(.trailing, to: .trailing, of: whiteRectangle, withOffset: -20)
        
    }
    
    
    private func buildViews() {
        view.backgroundColor = .white
        
        buildImage()
        
        buildRectangle()
        
        buildImageLabels()
        
        buildButton()
        
        buildRectangleLabels()
    }
}

