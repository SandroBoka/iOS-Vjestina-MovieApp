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
    
    struct MovieStruct {
        var id: Int
        var name: String
        var summary: String
        var imageUrl: String
        var releaseDate: String
        var year: Int
        var duration: Int
        var rating: Double
        var categories: [MovieCategoryModel]
        var crewNames: [String]
        var crewRoles: [String]
    }
    
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
        crewMembers = movieDetails.crewMembers
        
        if let crew = crewMembers {
            for person in crew {
                crewNames.append(person.name)
                crewRoles.append(person.role)
            }
        }
    }
    
    init() {
        
    }
    
    func getMovie() -> MovieStruct {
        return MovieStruct(id: self.id ?? 0,
                           name: self.name ?? "",
                           summary: self.summary ?? "",
                           imageUrl: self.imageUrl ?? "",
                           releaseDate: self.releaseDate ?? "",
                           year: self.year ?? 0,
                           duration: self.duration ?? 0,
                           rating: self.rating ?? 0.0,
                           categories: self.categories ?? [],
                           crewNames: self.crewNames,
                           crewRoles: self.crewRoles)
    }
}
