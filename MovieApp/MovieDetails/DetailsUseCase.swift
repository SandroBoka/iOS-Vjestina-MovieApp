//
//  DetailsUseCase.swift
//  MovieApp
//
//  Created by Sandro Boka on 31.05.2024..
//

import Foundation


class DetailsUseCase {
    
    private func createRequest(for urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func getDetails(movieId: Int) async -> DetailsResponse? {
        guard let detailsRequest = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/\(movieId)/details") 
            else { return nil }
        
        do {
            let (movieData, _) = try await URLSession.shared.data(for: detailsRequest)
            let detailsResponse = try JSONDecoder().decode(DetailsResponse.self, from: movieData)
            return detailsResponse
        } catch {
            print("Failed to fetch movie details: \(error)")
            return nil
        }
    }
}
