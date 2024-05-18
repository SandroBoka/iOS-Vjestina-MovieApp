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
    var footer: UIView!
    var whiteRectangle: UIView!
    var stackView: UIStackView!
    var movieCrewMembers: UILabel!
    var parentStack: UIStackView!
    
    var movieId : Int
    var movie = Movie()
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieDetails = MovieUseCase().getDetails(id: movieId) {
            movie = Movie(movieDetails: movieDetails)
        }
    
        
        buildViews(movieStruct: movie.getMovie())
        
        navigationItem.title = "Movie Details"
    }
    
    private func buildViews(movieStruct: Movie.MovieStruct) {
        view.backgroundColor = .white
        
        buildHeader(movieStruct: movieStruct)
        
        buildContent(movieStruct: movieStruct)
        
        buildFooter(movieStruct: movieStruct)
    }
    
    private func buildHeader(movieStruct: Movie.MovieStruct) {
        header = MovieDetailsHeaderView(movieStruct: movieStruct)
        view.addSubview(header)
        header.autoPinEdge(toSuperviewEdge: .leading)
        header.autoPinEdge(toSuperviewSafeArea: .top)
        header.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    
    private func buildContent(movieStruct: Movie.MovieStruct){
        content = MovieDetailsContentView(movieStruct: movieStruct)
        view.addSubview(content)
        content.autoPinEdge(.top, to: .bottom, of: header)
        content.autoPinEdge(toSuperviewEdge: .leading)
        content.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    
    private func buildFooter(movieStruct: Movie.MovieStruct) {
        footer = MovieDetailsFooterView(movieStruct: movieStruct)
        view.addSubview(footer)
        footer.autoPinEdge(toSuperviewEdge: .leading)
        footer.autoPinEdge(toSuperviewEdge: .trailing)
        footer.autoPinEdge(.top, to: .bottom, of: content)
        footer.autoPinEdge(toSuperviewEdge: .bottom)
    }
}

