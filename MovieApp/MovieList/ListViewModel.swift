//
//  ListViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import Combine

class ListViewModel {
    
    init() {
        getData()
    }
    
    @Published private(set) var moviesPublished : [MovieListData] = []
    
    func getData() {
        Task{
            let movieData = await ListUseCase().allMovies()
            
            moviesPublished = movieData.map {
                MovieListData(id: $0.id, imageUrl: $0.imageUrl, name: $0.name, summary: $0.summary, year: $0.year)
            }
        }
    }
}
