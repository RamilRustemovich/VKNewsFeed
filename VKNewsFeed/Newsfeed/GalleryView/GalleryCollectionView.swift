//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Ramil on 10/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

final class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
  
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    // MARK: init
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        rowLayout.delegate = self
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
//        if let rowLayout = collectionViewLayout as? RowLayout {
//            rowLayout.delegate = self
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as? GalleryCollectionViewCell
        cell?.set(imageUrl: self.photos[indexPath.row].photoUrlString)
        return cell ?? UICollectionViewCell()
    }
    
    
}

// MARK: RowLayoutDelegate
extension GalleryCollectionView: RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = self.photos[indexPath.row].width
        let height = self.photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
