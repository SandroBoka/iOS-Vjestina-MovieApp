//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import Combine

class DetailsViewModel {
    
    init(movieId: Int) {
        getData(movieId: movieId)
    }
    
    @Published private(set) var movie : Movie!
    
    func getData(movieId: Int) {
        movie = Movie()
        
        Task {
            if let detailsResponse = await DetailsUseCase().getDetails(movieId: movieId) {
                // Update the movie property with the detailsResponse
                movie = Movie(movieDetails: detailsResponse)
            }
        }
    }
}
