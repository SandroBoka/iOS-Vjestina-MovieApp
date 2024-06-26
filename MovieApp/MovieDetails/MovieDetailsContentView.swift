//
//  MovieDetailsContentView.swift
//  MovieApp
//
//  Created by Sandro Boka on 04.05.2024..
//

import Foundation
import UIKit
import PureLayout

class MovieDetailsContentView: UIView {
    
    var movieSummary: UILabel!
    
    init(movieStruct: Movie) {
        super.init(frame: .zero)
        setup(movieStruct: movieStruct)
    }
    
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(movieStruct: Movie) {
        self.backgroundColor = .white
        
        movieSummary = UILabel()
        
        movieSummary.text = movieStruct.summary
        
        let overviewLabel = UILabel()
        overviewLabel.textColor = UIColor(red: 0.1, green: 0.4, blue: 0.5, alpha: 1.0)
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        self.addSubview(overviewLabel)
        overviewLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        overviewLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 30)
        overviewLabel.autoPinEdge(.trailing, to: .trailing, of: self)
        
        movieSummary.font = UIFont.systemFont(ofSize: 15)
        movieSummary.translatesAutoresizingMaskIntoConstraints = false
        movieSummary.numberOfLines = 0
        movieSummary.alpha = 0
        self.addSubview(movieSummary)
        movieSummary.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        movieSummary.autoPinEdge(.top, to: .top, of: overviewLabel, withOffset: 40)
        movieSummary.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -20)
        movieSummary.autoPinEdge(.bottom, to: .bottom, of: self)
        
        self.layoutIfNeeded()
        
    }
    
    func startAnimation() {
        movieSummary.transform = transform.translatedBy(x: -self.frame.width, y: 0)
        movieSummary.alpha = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.01,
            options: [.curveLinear],
            animations: { [weak self] in
                guard let self else { return }
                
                self.movieSummary.transform = .identity
                self.layoutIfNeeded()
            })
    }
}
