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
    
    // I made two versions, one where the views inside of this tab bar are their own navigation controllers and one where the tab bar itself is
    // the navigation controller (the parts throuout the code which are commented out are the second approach)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationItem.title = "Movie List"
        tabBar.tintColor = .black
        
        configureTabs()
    }


    
    private func configureTabs(){
        let vc1 = MovieCategoriesViewController()
        let vc2 = FavoritesViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        vc1.title = "Movie List"
        vc2.tabBarItem.title = "Favorites"
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        
        vc1.configureRouter(navigationController: nc1)
        
        setViewControllers([nc1, nc2], animated: true)
    }
}
