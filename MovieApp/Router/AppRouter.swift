//
//  AppRouter.swift
//  MovieApp
//
//  Created by Sandro Boka on 18.05.2024..
//

import UIKit

class AppRouter: AppRouterProtocol {
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        
        let vc = MovieTabBarController(router: self)
        
        navigationController.pushViewController(vc, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetails(movieId: Int) {
        
        let vc = MovieDetailsViewController(movieId: movieId)
        navigationController.pushViewController(vc, animated: true)
    }
}
