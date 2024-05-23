//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 18.05.2024..
//

import Foundation
import UIKit
import PureLayout


class FavoritesViewController: UIViewController {
    
    private var router: AppRouter!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
}
