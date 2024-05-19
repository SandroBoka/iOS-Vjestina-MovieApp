
//  MovieDetailsFooterView.swift
//  MovieApp
//
//  Created by Sandro Boka on 04.05.2024..
//

import Foundation
import UIKit

class MovieDetailsFooterView: UIView {
    
    init(movieStruct: Movie.MovieStruct) {
        super.init(frame: .zero)
        setup(movieStruct: movieStruct)
    }
    
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(movieStruct: Movie.MovieStruct) {
        self.backgroundColor = .white
        
        displayCrewInfo(movieStruct: movieStruct)
    }
    
    private func displayCrewInfo(movieStruct: Movie.MovieStruct) {
        let parentStack = UIStackView()
        parentStack.alpha = 0 // animation
        self.addSubview(parentStack)
        parentStack.axis = .vertical
        parentStack.alignment = .fill
        parentStack.distribution = .fillEqually
        parentStack.spacing = 30
        parentStack.autoPinEdge(.leading, to: .leading, of: self, withOffset: 10)
        parentStack.autoPinEdge(.top, to: .top, of: self, withOffset: 30)
        parentStack.autoPinEdge(.trailing, to: .trailing, of: self)
        
        let numOfRows = (movieStruct.crewNames.count + 2) / 3
        var index = 0
        
        // animation
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                   parentStack.alpha = 1
               })
        
        for _ in 0...numOfRows - 1{
            let innerStackView = UIStackView()
            innerStackView.axis = .horizontal
            innerStackView.alignment = .center
            innerStackView.distribution = .fillEqually
            parentStack.addArrangedSubview(innerStackView)
            
            let fields = [UIView(), UIView(), UIView()]
            
            for field in fields {
                field.autoSetDimension(.height, toSize: 60)
                innerStackView.addArrangedSubview(field)
                
                if index <= movieStruct.crewNames.count - 1 {
                    let nameLabel = UILabel()
                    nameLabel.text = movieStruct.crewNames[index]
                    nameLabel.font = UIFont.systemFont(ofSize: 13.5, weight: .heavy)
                    nameLabel.translatesAutoresizingMaskIntoConstraints = true
                    nameLabel.numberOfLines = 0
                    field.addSubview(nameLabel)
                    nameLabel.autoPinEdge(.top, to: .top, of: field, withOffset: 5)
                    nameLabel.autoPinEdge(.leading, to: .leading, of: field)
                    nameLabel.autoPinEdge(.trailing, to: .trailing, of: field)
                    
                    let roleLabel = UILabel()
                    roleLabel.text = movieStruct.crewRoles[index]
                    roleLabel.font = UIFont.systemFont(ofSize: 15)
                    field.addSubview(roleLabel)
                    roleLabel.autoPinEdge(.top, to: .top, of: nameLabel, withOffset: 30)
                    roleLabel.autoPinEdge(.left, to: .left, of: field)
                    roleLabel.autoPinEdge(.trailing, to: .trailing, of: field)
                    roleLabel.autoPinEdge(.bottom, to: .bottom, of: field)
                    
                    index += 1
                }
            }
        }
    }
}
