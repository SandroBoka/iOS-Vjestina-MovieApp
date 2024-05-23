//
//  MovieCategoriesViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 07.05.2024..
//

import UIKit
import PureLayout
import Foundation
import MovieAppData

class MovieCategoriesViewController: UIViewController {
    
    var tableView = UITableView()
    var data: [[MovieModel]] = []
    let cellName = "CollectionCell"
    
    private var router: AppRouter!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(MovieUseCase().popularMovies)
        data.append(MovieUseCase().freeToWatchMovies)
        data.append(MovieUseCase().trendingMovies)
        
        view.backgroundColor = .white
        
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        tableView.rowHeight = 170
        tableView.autoPinEdgesToSuperviewSafeArea()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(CollectionCell.self, forCellReuseIdentifier: cellName)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension MovieCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? CollectionCell else {
            return UITableViewCell()
        }
        let movies = data[indexPath.section]
        cell.setCellData(movies: movies, router: router)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "What's Popular"
        case 1:
            return "Free To Watch"
        case 2:
            return "Trending"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 17, width: tableView.frame.width - 20, height: 40))
        titleLabel.textColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
}
