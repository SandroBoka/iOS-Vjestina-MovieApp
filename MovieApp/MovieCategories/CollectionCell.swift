//
//  CollectionCell.swift
//  MovieApp
//
//  Created by Sandro Boka on 07.05.2024..
//

import UIKit
import PureLayout

class CollectionCell: UITableViewCell {
    
    var movies: [MovieCellData] = []
    var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    let cellName = "ImageCell"
    private var router: AppRouter!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCellData(movies: [MovieCellData], router: AppRouter) {
        self.movies = movies
        self.router = router
        self.collectionView.reloadData()
    }
    
    
    private func configureCollectionView() {
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceHorizontal = true
        
        self.contentView.addSubview(collectionView)
        
        collectionView.autoPinEdgesToSuperviewEdges()
        
        setCollectionViewDelegates()
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellName)
    }
    
    private func setCollectionViewDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func showDetails(movieId: Int) {
        router.showMovieDetails(movieId: movieId)
    }
}


extension CollectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        cell.setImageCellData(movieModel: movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell{
            showDetails(movieId: cell.movieId)
        }
    }
}

extension CollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: collectionView.bounds.height)
    }
}

