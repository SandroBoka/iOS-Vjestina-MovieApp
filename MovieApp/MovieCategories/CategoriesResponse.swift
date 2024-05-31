//
//  CategoriesResponse.swift
//  MovieApp
//
//  Created by Sandro Boka on 31.05.2024..
//

import Foundation

struct CategoriesResponse: Decodable, Hashable{
    
    var id : Int
    var imageUrl: String
    var name: String
    var summary: String
    var year: Int
}
