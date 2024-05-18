//
//  ImageCell.swift
//  MovieApp
//
//  Created by Sandro Boka on 07.05.2024..
//

import UIKit
import PureLayout
import MovieAppData

class ImageCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        configureImageView()
        buildButton()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImageCellData(movieModel: MovieModel) {
        let url = URL(string: movieModel.imageUrl)!
        let cacheKey = NSString(string: movieModel.imageUrl)
        
        // Check if the image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            self.imageView.image = cachedImage
        } else {
            // If not, download the image
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    // Cache the image
                    ImageCache.shared.setObject(image, forKey: cacheKey)
                    
                    // Update the image view on the main thread
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }

    
    
    private func configureImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        
        imageView.autoPinEdgesToSuperviewEdges()
    }
    
    private func buildButton() {
        let emptyView = UIView()
        imageView.addSubview(emptyView)
        emptyView.autoPinEdge(.leading, to: .leading, of: imageView, withOffset: 5)
        emptyView.autoPinEdge(.top, to: .top, of: imageView, withOffset: 5)

        
        emptyView.autoSetDimensions(to: CGSize(width: 40, height: 40))
        
        let button = UIButton(type: .custom)
        emptyView.addSubview(button)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.autoSetDimensions(to: CGSize(width: 30, height: 30))
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.opacity = 0.7
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.autoCenterInSuperview()
    }
}
