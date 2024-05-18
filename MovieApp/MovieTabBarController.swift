//
//  MovieTabBarController.swift
//  MovieApp
//
//  Created by Sandro Boka on 18.05.2024..
//

import UIKit

class MovieTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var router: AppRouter!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
        configureTabs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationItem.title = "Movie List"
    }


    
    private func configureTabs(){
        let vc1 = MovieCategoriesViewController(router: self.router)
        let vc2 = FavoritesViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        
        vc1.tabBarItem.title = "Movie List"
        vc2.tabBarItem.title = "Favorites"
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            // Check which view controller was selected
            if viewController is MovieCategoriesViewController {
                self.navigationItem.title = "Movie List"
            } else if viewController is FavoritesViewController {
                self.navigationItem.title = ""
            }
        }
}
