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
    var imageUrl: String
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
        imageUrl = movieDetails.imageUrl
        releaseDate = movieDetails.releaseDate
        year = movieDetails.year
        duration = movieDetails.duration
        rating = movieDetails.rating
        categories = movieDetails.categories
        crewNames = movieDetails.crewMembers.map { $0.name }
        crewRoles = movieDetails.crewMembers.map { $0.role }
    }
    
    // Default initializer for an empty movie
    init() {
        id = 0
        name = ""
        summary = ""
        imageUrl = ""
        releaseDate = ""
        year = 0
        duration = 0
        rating = 0.0
        categories = []
        crewNames = []
        crewRoles = []
    }
}
