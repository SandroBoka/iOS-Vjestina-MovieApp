//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 06.05.2024..
//

import Foundation
import UIKit
import PureLayout
import Combine

class MovieListViewController: UIViewController {
    
    var tableView = UITableView()
    var movies: [Movie] = []
    let cellName = "MovieCell"
    
    private var router: AppRouter!
    private var listViewModel = ListViewModel()
    private var disposables = Set<AnyCancellable>()
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies = listViewModel.moviesPublished
        listViewModel
            .$moviesPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }

                self.movies = movies
                self.tableView.reloadData()
            }
            .store(in: &disposables)
        view.backgroundColor = .white
        navigationItem.title = "Movie List"
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
    
    @objc func showDetails(movieId: Int) {
        router.showMovieDetails(movieId: movieId)
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
        cell.setCellData(movieModel: movie, router: router)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MovieCell{
            showDetails(movieId: cell.movieId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
