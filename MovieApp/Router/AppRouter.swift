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
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showTabView()
    }
    
    func showTabView() {
        let tabViewController = MovieTabBarController()
        let vc1 = MovieCategoriesViewController(router: self)
        let vc2 = MovieListViewController(router: self)
//        let vc2 = FavoritesViewController(router: self)
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        vc1.title = "Movie List"
        vc2.title = "Favorites"
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        
        tabViewController.setViewControllers([nc1, nc2], animated: true)
        navigationController.setViewControllers([tabViewController], animated: false)
    }
    
    func showMovieDetails(movieId: Int) {
        guard
            let currentViewController = navigationController.viewControllers.last as? MovieTabBarController,
            let nav = currentViewController.selectedViewController as? UINavigationController
        else {
            return
        }
        
        let vc = MovieDetailsViewController(movieId: movieId)
        nav.pushViewController(vc, animated: true)
    }
}
