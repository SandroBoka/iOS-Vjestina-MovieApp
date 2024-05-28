//
//  CategoriesViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import Combine
import MovieAppData


class CategoriesViewModel {
    
    init() {
        getData()
    }
    
    @Published private(set) var moviesPublished : [[MovieCellData]] = []
    
    func getData(){
        
        moviesPublished.append(MovieUseCase().popularMovies.map{
            MovieCellData(movieModel: $0)
        })
        
        moviesPublished.append(MovieUseCase().freeToWatchMovies.map{
            MovieCellData(movieModel: $0)
        })
        moviesPublished.append(MovieUseCase().trendingMovies.map{
            MovieCellData(movieModel: $0)
        })
    }
}
