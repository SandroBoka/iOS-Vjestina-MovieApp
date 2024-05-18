//
//  MovieTabBarController.swift
//  MovieApp
//
//  Created by Sandro Boka on 18.05.2024..
//

import UIKit

class MovieTabBarController: UITabBarController, UITabBarControllerDelegate {
    
//    private var router: AppRouter!
//    
//    convenience init(router: AppRouter) {
//        self.init()
//        self.router = router
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationItem.title = "Movie List"
        
        configureTabs()
    }


    
    private func configureTabs(){
        let vc1 = MovieCategoriesViewController()
        let vc2 = FavoritesViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        
        vc1.title = "Movie List"
        vc2.tabBarItem.title = "Favorites"
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        
        vc1.configureRouter(navigationController: nc1)
        
        setViewControllers([nc1, nc2], animated: true)
    }
}
