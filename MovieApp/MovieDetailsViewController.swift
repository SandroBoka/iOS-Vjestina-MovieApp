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
    
    var header: UIView!
    var content: UIView!
    var whiteRectangle: UIView!
    var stackView: UIStackView!
    var movieCrewMembers: UILabel!
    var parentStack: UIStackView!
    
    var movieId =  110357
    var movie = Movie()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieDetails = MovieUseCase().getDetails(id: movieId) {
            movie = Movie(movieDetails: movieDetails)
        }
    
        
        buildViews(movieStruct: movie.getMovie())
    }
    
    private func buildViews(movieStruct: Movie.MovieStruct) {
        view.backgroundColor = .white
        
        buildHeader(movieStruct: movieStruct)
        
        buildContent(movieStruct: movieStruct)
        
        buildRectangle(movieStruct: movieStruct)
        
        buildRectangleLabels(movieStruct: movieStruct)
    }
    
    private func buildHeader(movieStruct: Movie.MovieStruct) {
        header = MovieDetailsHeaderView(movieStruct: movieStruct)
        view.addSubview(header)
        header.autoPinEdge(toSuperviewEdge: .leading)
        header.autoPinEdge(toSuperviewEdge: .top)
        header.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    
    private func buildContent(movieStruct: Movie.MovieStruct){
        content = MovieDetailsContentView(movieStruct: movieStruct)
        view.addSubview(content)
        content.autoPinEdge(.top, to: .bottom, of: header)
        content.autoPinEdge(toSuperviewEdge: .leading)
        content.autoPinEdge(toSuperviewEdge: .trailing)
    }

    
    private func buildRectangle(movieStruct: Movie.MovieStruct) {
        whiteRectangle = UIView()
        whiteRectangle.backgroundColor = .white
        view.addSubview(whiteRectangle)
        whiteRectangle.autoPinEdge(.top, to: .bottom, of: content)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .leading)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .bottom)
        whiteRectangle.autoPinEdge(toSuperviewEdge: .trailing)
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
    
    private func buildRectangleLabels(movieStruct: Movie.MovieStruct) {
    
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
}

