//
//  RowLayout.swift
//  VKNewsFeed
//
//  Created by Ramil on 10/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

final class RowLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    static let numberOfrows = 2
    private var cellPadding: CGFloat = 8
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contenstWidth: CGFloat = 0
    private var contenstHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contenstWidth, height: contenstHeight)
    }
    
    override func prepare() {
        self.cache = []
        self.contenstWidth = 0
        guard self.cache.isEmpty, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = self.delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superviewWidth = collectionView.frame.width
        guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: superviewWidth, photoSize: photos) else { return }
        rowHeight = rowHeight / CGFloat(RowLayout.numberOfrows)
        let photosRatios = photos.map { $0.height / $0.width }
        
        var yOffset = [CGFloat]()
        for row in 0..<RowLayout.numberOfrows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numberOfrows)
        
        var row = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let ratio = photosRatios[indexPath.row] // просто итем ставить??
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            self.cache.append(attribute)
            
            self.contenstWidth = max(self.contenstWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            row = row < RowLayout.numberOfrows - 1 ? row + 1 : 0 
        }
        
    }
    
    static func rowHeightCounter(superviewWidth: CGFloat, photoSize: [CGSize]) -> CGFloat? {
        let photoMinRatio = photoSize.min { (first, second) in // через мап сделать?
            (first.height / first.width) < (second.height / second.width)
        }
        guard let _photoMinRatio = photoMinRatio else { return nil }
        let difference = superviewWidth / _photoMinRatio.width
        let rowHeight: CGFloat = (_photoMinRatio.height * difference) * CGFloat(RowLayout.numberOfrows)
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in self.cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.row]
    }
    
}
