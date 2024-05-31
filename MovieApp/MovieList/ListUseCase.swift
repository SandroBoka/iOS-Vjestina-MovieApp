//
//  ListUseController.swift
//  MovieApp
//
//  Created by Sandro Boka on 31.05.2024..
//

import Foundation


class ListUseCase {
    
    var movieSet: Set<CategoriesResponse> = []
    
    func allMovies() async -> [CategoriesResponse] {
        let categoriesUseCase = CategoriesUseCase()
        
        let popularResponse = await categoriesUseCase.popularMovies()
        movieSet.formUnion(popularResponse)
        
        let freeResponse = await categoriesUseCase.freeToWatchMovies()
        movieSet.formUnion(freeResponse)
        
        let trendingResponse = await categoriesUseCase.trendingMovies()
        movieSet.formUnion(trendingResponse)
        
        return Array(movieSet)
    }
}
