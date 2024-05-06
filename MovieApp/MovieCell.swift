//
//  MovieCell.swift
//  MovieApp
//
//  Created by Sandro Boka on 06.05.2024..
//

import UIKit
import MovieAppData

class MovieCell: UITableViewCell {
    
    var movieImageView = UIImageView()
    var movieInfoView = UIView()
    var movieTitleLabel = UILabel()
    var movieSummaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieImageView)
        addSubview(movieInfoView)
        
        configureImageView()
        configureInfoView()
        configureTitleLabel()
        configureSummaryLabel()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10 // Rounded edges
        self.layer.masksToBounds = false // Allow shadows
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCellData(movieModel: MovieModel) {
        let url = URL(string: movieModel.imageUrl)!
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    self.movieImageView.image = UIImage(data: data)
                }
            }
        }
        
        let year = MovieUseCase().getDetails(id: movieModel.id)?.year
        
        movieTitleLabel.text = movieModel.name + " (" + String(year!) + ")"
        movieSummaryLabel.text = movieModel.summary
    }
    
    
    private func configureImageView() {
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFit
        
        movieImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 5)
        movieImageView.autoPinEdge(toSuperviewEdge: .top)
        movieImageView.autoPinEdge(toSuperviewEdge: .bottom)
        
        movieImageView.autoSetDimension(.width, toSize: 100)
    }
    
    
    private func configureInfoView() {
        movieInfoView.addSubview(movieTitleLabel)
        movieInfoView.addSubview(movieSummaryLabel)
        
        movieInfoView.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 10)
        movieInfoView.autoPinEdge(toSuperviewEdge: .top)
        movieInfoView.autoPinEdge(toSuperviewEdge: .trailing)
        movieInfoView.autoPinEdge(toSuperviewEdge: .bottom)
        
        movieTitleLabel.autoPinEdge(.top, to: .top, of: movieInfoView, withOffset: 10)
        movieTitleLabel.autoPinEdge(.leading, to: .leading, of: movieInfoView, withOffset: 10)
        movieTitleLabel.autoPinEdge(.trailing, to: .trailing, of: movieInfoView, withOffset: -10)
        
        movieSummaryLabel.autoPinEdge(.top, to: .bottom, of: movieTitleLabel, withOffset: 10)
        movieSummaryLabel.autoPinEdge(.leading, to: .leading, of: movieInfoView, withOffset: 10)
        movieSummaryLabel.autoPinEdge(.trailing, to: .trailing, of: movieInfoView, withOffset: -10)
        movieSummaryLabel.autoPinEdge(.bottom, to: .bottom, of: movieInfoView, withOffset: -10)
    }
    
    
    private func configureTitleLabel() {
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func configureSummaryLabel() {
        movieSummaryLabel.textColor = .lightGray
        movieSummaryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        movieSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        movieSummaryLabel.numberOfLines = 0
    }
}
