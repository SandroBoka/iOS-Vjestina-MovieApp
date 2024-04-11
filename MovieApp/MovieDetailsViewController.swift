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
    var parentStack: UIStackView!
    
    var movie = Movie(movieId: 110357)
    
    
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
            
            movieCategories.text = categories.map { String(describing: $0).capitalized }.joined(separator: ", ")
            
            let hours = Int(duration / 60)
            let minutes = duration % 60
            movieDuration.text = String(hours) + "h " + String(minutes) + "m"
        }
        
        movieRating.textColor = .white
        movieRating.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        imageView.addSubview(movieRating)
        movieRating.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieRating.autoPinEdge(.top, to: .top, of: imageView, withOffset: 120)
        
        let label1 = UILabel()
        label1.text = "User score"
        label1.textColor = .white
        label1.font = UIFont.boldSystemFont(ofSize: 16)
        imageView.addSubview(label1)
        label1.autoPinEdge(.leading, to: .trailing, of: movieRating, withOffset: 10)
        label1.autoAlignAxis(.horizontal, toSameAxisOf: movieRating)
        
        movieName.textColor = .white
        movieName.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        imageView.addSubview(movieName)
        movieName.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieName.autoPinEdge(.top, to: .top, of: imageView, withOffset: 170)
        movieName.autoPinEdge(.trailing, to: .trailing, of: imageView)
        
        movieYear.textColor = .white
        movieYear.font = UIFont.systemFont(ofSize: 22)
        imageView.addSubview(movieYear)
        movieYear.autoPinEdge(.leading, to: .trailing, of: movieName, withOffset: 5)
        movieYear.autoPinEdge(.top, to: .top, of: imageView, withOffset: 170)
        
        movieReleseDate.textColor = .white
        movieReleseDate.font = UIFont.systemFont(ofSize: 16)
        imageView.addSubview(movieReleseDate)
        movieReleseDate.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieReleseDate.autoPinEdge(.top, to: .top, of: imageView, withOffset: 220)
        
        movieCategories.textColor = .white
        movieCategories.font = UIFont.systemFont(ofSize: 16)
        imageView.addSubview(movieCategories)
        movieCategories.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 15)
        movieCategories.autoPinEdge(.top, to: .top, of: imageView, withOffset: 245)
        
        movieDuration.textColor = .white
        movieDuration.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
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
    
    private func displayCrewInfo() {
        
        var numOfRows = movie.crewNames.count / 3
        if movie.crewNames.count % 3 != 0 {
            numOfRows += 1
        }
        
        for row in 0...numOfRows - 1 {
            let infoStackView = UIStackView()
            infoStackView.axis = .horizontal
            infoStackView.alignment = .center
            infoStackView.distribution = .fillEqually
            parentStack.addArrangedSubview(infoStackView)
            
            let greenRectangle = UIView()
            let pinkRectangle = UIView()
            let yellowRectangle = UIView()
            let rectangleList = [greenRectangle, pinkRectangle, yellowRectangle]
            
            for i in 0...2 {
                rectangleList[i].autoSetDimension(.height, toSize: 60)
                infoStackView.addArrangedSubview(rectangleList[i])
                
                for j in 0...movie.crewNames.count - 1 {
                    if j == i + 3 * row {
                        let nameLabel = UILabel()
                        nameLabel.text = movie.crewNames[j]
                        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
                        rectangleList[i].addSubview(nameLabel)
                        nameLabel.autoPinEdge(.top, to: .top, of: rectangleList[i], withOffset: 5)
                        nameLabel.autoPinEdge(.left, to: .left, of: rectangleList[i])
                        let roleLabel = UILabel()
                        roleLabel.text = movie.crewRoles[j]
                        roleLabel.font = UIFont.systemFont(ofSize: 15)
                        rectangleList[i].addSubview(roleLabel)
                        roleLabel.autoPinEdge(.top, to: .top, of: rectangleList[i], withOffset: 30)
                        roleLabel.autoPinEdge(.left, to: .left, of: rectangleList[i])
                    }
                }
            }
        }
    }
    
    private func buildRectangleLabels() {
        movieSummary = UILabel()
        
        if let summary = movie.summary
        {
            movieSummary.text = summary
        }
        
        let label2 = UILabel()
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
        
        parentStack = UIStackView()
        whiteRectangle.addSubview(parentStack)
        parentStack.axis = .vertical
        parentStack.alignment = .fill
        parentStack.distribution = .fillEqually
        parentStack.spacing = 30
        parentStack.autoPinEdge(.leading, to: .leading, of: whiteRectangle, withOffset: 15)
        parentStack.autoPinEdge(.top, to: .top, of: whiteRectangle, withOffset: 160)
        parentStack.autoPinEdge(.trailing, to: .trailing, of: whiteRectangle, withOffset: -15)
        
        displayCrewInfo()
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

