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
    var infoView = UIView()
    var titleLabel = UILabel()
    var summaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(infoView)
        
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
        
        titleLabel.text = movieModel.name + " (" + String(year!) + ")"
        summaryLabel.text = movieModel.summary
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
        infoView.addSubview(titleLabel)
        infoView.addSubview(summaryLabel)
        
        infoView.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 10)
        infoView.autoPinEdge(toSuperviewEdge: .top)
        infoView.autoPinEdge(toSuperviewEdge: .trailing)
        infoView.autoPinEdge(toSuperviewEdge: .bottom)
        
        titleLabel.autoPinEdge(.top, to: .top, of: infoView, withOffset: 10)
        titleLabel.autoPinEdge(.leading, to: .leading, of: infoView, withOffset: 10)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: infoView, withOffset: -10)
        
        summaryLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        summaryLabel.autoPinEdge(.leading, to: .leading, of: infoView, withOffset: 10)
        summaryLabel.autoPinEdge(.trailing, to: .trailing, of: infoView, withOffset: -10)
        summaryLabel.autoPinEdge(.bottom, to: .bottom, of: infoView, withOffset: -10)
    }
    
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func configureSummaryLabel() {
        summaryLabel.textColor = .lightGray
        summaryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 0
    }
}
