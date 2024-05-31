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
    var categories: [String]
    var crewNames = [String]()
    var crewRoles = [String]()
    
    
    init(movieDetails: DetailsResponse) {
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
    
    // default init
    init() {
        id = 0
        name = "none"
        summary = "none"
        imageUrl = URL(string:"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fstore.empty%2F&psig=AOvVaw3Z_c-pQ_EPDcXcZSAaGsvJ&ust=1717234447231000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMiY-fzKt4YDFQAAAAAdAAAAABAE")!
        releaseDate = "00-00-00"
        year = 0
        duration = 0
        rating = 0.0
        categories = ["none"]
        crewNames = ["none"]
        crewRoles = ["none"]
    }
}
