//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import MovieAppData
import Combine

class DetailsViewModel {
    
    init(movieId: Int) {
        getData(movieId: movieId)
    }
    
    @Published private(set) var movie : Movie!
    
    func getData(movieId: Int) {
        if let movieDetails = MovieUseCase().getDetails(id: movieId) {
            movie = Movie(movieDetails: movieDetails)
        }
    }
}
