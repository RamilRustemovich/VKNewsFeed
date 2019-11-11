//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Ramil on 10/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let myImageView: WebImageView = {
       let imgView = WebImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = #colorLiteral(red: 0.9117140174, green: 0.9184567928, blue: 0.9278435111, alpha: 1)
        return imgView
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // myImageView constraints
        addSubview(self.myImageView)
        self.myImageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageUrl: String?) {
        self.myImageView.set(imageURL: imageUrl)
    }
    
    // MARK: other methods
    override func prepareForReuse() {
        self.myImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
}
