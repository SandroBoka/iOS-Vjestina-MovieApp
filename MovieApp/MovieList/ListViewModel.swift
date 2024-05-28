//
//  ListViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import Combine
import MovieAppData

class ListViewModel {
    
    init() {
        getData()
    }
    
    @Published private(set) var moviesPublished : [Movie] = []
    
    func getData(){
        
        let movieData = MovieUseCase().allMovies
        for movie in movieData {
            if let movieDetails = MovieUseCase().getDetails(id: movie.id) {
                moviesPublished.append(Movie(movieDetails: movieDetails))
            }
        }
    }
}
