//
//  CategoriesUseCase.swift
//  MovieApp
//
//  Created by Sandro Boka on 31.05.2024..
//

import Foundation

class CategoriesUseCase {
    
    let popular = ["FOR_RENT", "IN_THEATERS", "ON_TV, STREAMING"]
    let free = ["MOVIE", "TV_SHOW"]
    let trending = ["THIS_WEEK", "TODAY"]
    
    private func createRequest(for urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func popularMovies() async -> [CategoriesResponse] {
        var movieSet: Set<CategoriesResponse> = []
        
        for criteria in popular {
            guard
                let popularMoviesRequest = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/popular?criteria=\(criteria)")
            else { continue }
            
            do {
                let (popularMoviesData, _) = try await URLSession.shared.data(for: popularMoviesRequest)
                if let popularMovies = try? JSONDecoder().decode([CategoriesResponse].self, from: popularMoviesData) {
                    movieSet.formUnion(popularMovies)
                }
            } catch {
                print("Failed to fetch popular movies for criteria \(criteria): \(error)")
            }
        }
        
        return Array(movieSet)
    }
    
    func freeToWatchMovies() async -> [CategoriesResponse] {
        var movieSet: Set<CategoriesResponse> = []
        
        for criteria in free {
            guard
                let freeMoviesRequest = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/free-to-watch?criteria=\(criteria)")
            else { continue }
            
            do {
                let (freeMoviesData, _) = try await URLSession.shared.data(for: freeMoviesRequest)
                if let freeMovies = try? JSONDecoder().decode([CategoriesResponse].self, from: freeMoviesData) {
                    movieSet.formUnion(freeMovies)
                }
            } catch {
                print("Failed to fetch popular movies for criteria \(criteria): \(error)")
            }
        }
        
        return Array(movieSet)
    }
    
    func trendingMovies() async -> [CategoriesResponse] {
        var movieSet: Set<CategoriesResponse> = []
        
        for criteria in trending {
            guard
                let trendingMoviesRequest = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/trending?criteria=\(criteria)")
            else { continue }
            
            do {
                let (trendingMoviesData, _) = try await URLSession.shared.data(for: trendingMoviesRequest)
                if let trendingMovies = try? JSONDecoder().decode([CategoriesResponse].self, from: trendingMoviesData) {
                    movieSet.formUnion(trendingMovies)
                }
            } catch {
                print("Failed to fetch popular movies for criteria \(criteria): \(error)")
            }
        }
        
        return Array(movieSet)
    }
}
