//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 06.05.2024..
//

import Foundation
import UIKit
import MovieAppData
import PureLayout

class MovieListViewController: UIViewController {
    
    var tableView = UITableView()
    var movies: [MovieModel] = []
    let cellName = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies = MovieUseCase().allMovies
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        tableView.rowHeight = 150
        tableView.autoPinEdgesToSuperviewSafeArea()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellName)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Assuming each movie belongs to a different section
        return movies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Each section will have only one row (one movie)
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.section] // Modified to use indexPath.section
        cell.setCellData(movieModel: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Add spacing between sections by providing a height for the header
        return 0 // Adjust the value as needed
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a transparent view to act as a spacer between sections
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}
