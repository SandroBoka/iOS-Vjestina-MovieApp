//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Sandro Boka on 31.05.2024..
//

import Foundation

struct DetailsResponse: Decodable {
    var id: Int
    var name: String
    var year: Int
    var duration: Int
    var releaseDate: String
    var rating: Double
    var summary: String
    var imageUrl: String
    var categories: [String]
    var crewMembers: [CrewMember]
}


struct CrewMember: Decodable {
    var name: String
    var role: String
}
