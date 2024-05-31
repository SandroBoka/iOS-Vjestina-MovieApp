//
//  MovieCellData.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import UIKit
import MovieAppData

struct MovieCellData {
    
    let id: Int
    let url: URL
    let name: String
    
    init(movie: CategoriesResponse) {
        id = movie.id
        url = URL(string: movie.imageUrl)!
        name = movie.name
    }
}
