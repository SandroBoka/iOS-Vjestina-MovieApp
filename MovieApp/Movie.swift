//
//  Movie.swift
//  MovieApp
//
//  Created by Sandro Boka on 30.03.2024..
//

import Foundation
import MovieAppData

class Movie {
    var id: Int?
    var name: String?
    var summary: String?
    var imageUrl: String?
    var releaseDate: String?
    var year: Int?
    var duration: Int?
    var rating: Double?
    var categories: [MovieCategoryModel]?
    var crewMembers: [MovieCrewMemberModel]?
    var crewNames = [String]()
    var crewRoles = [String]()
    
    init(movieId: Int) {
        if let movieDetails = MovieUseCase().getDetails(id: movieId) {
            id = movieDetails.id
            name = movieDetails.name
            summary = movieDetails.summary
            imageUrl = movieDetails.imageUrl
            releaseDate = movieDetails.releaseDate
            year = movieDetails.year
            duration = movieDetails.duration
            rating = movieDetails.rating
            categories = movieDetails.categories
            crewMembers = movieDetails.crewMembers
        }
        
        if let crew = crewMembers {
            for person in crew {
                crewNames.append(person.name)
                crewRoles.append(person.role)
            }
        }
    }
}
