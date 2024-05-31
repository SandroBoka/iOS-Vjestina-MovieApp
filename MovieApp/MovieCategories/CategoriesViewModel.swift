//
//  CategoriesViewModel.swift
//  MovieApp
//
//  Created by Sandro Boka on 28.05.2024..
//

import Foundation
import Combine


class CategoriesViewModel {
    
    init() {
        getData()
    }
    
    @Published private(set) var moviesPublished : [[MovieCellData]] = []
    
    func getData(){
        
        Task{
            let popularResponse = await CategoriesUseCase().popularMovies()
            moviesPublished.append(popularResponse.map{
                MovieCellData(movie: $0)
            })
            
            let freeResponse = await CategoriesUseCase().freeToWatchMovies()
            moviesPublished.append(freeResponse.map{
                MovieCellData(movie: $0)
            })
            
            let trendingResponse = await CategoriesUseCase().trendingMovies()
            moviesPublished.append(trendingResponse.map{
                MovieCellData(movie: $0)
            })
        }
    }
}
