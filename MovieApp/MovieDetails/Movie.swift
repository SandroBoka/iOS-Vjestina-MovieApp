//
//  Movie.swift
//  MovieApp
//
//  Created by Sandro Boka on 30.03.2024..
//

import Foundation
import MovieAppData

struct Movie {
    var id: Int
    var name: String
    var summary: String
    var imageUrl: URL
    var releaseDate: String
    var year: Int
    var duration: Int
    var rating: Double
    var categories: [MovieCategoryModel]
    var crewNames = [String]()
    var crewRoles = [String]()
    
    
    init(movieDetails: MovieDetailsModel) {
        id = movieDetails.id
        name = movieDetails.name
        summary = movieDetails.summary
        imageUrl = URL(string:movieDetails.imageUrl)!
        releaseDate = movieDetails.releaseDate
        year = movieDetails.year
        duration = movieDetails.duration
        rating = movieDetails.rating
        categories = movieDetails.categories
        crewNames = movieDetails.crewMembers.map { $0.name }
        crewRoles = movieDetails.crewMembers.map { $0.role }
    }
}
