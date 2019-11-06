//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Ramil on 05/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit


struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class NewsfeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
   
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = self.screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: работа с postLabelFrame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: работа с attachmentFrame
        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        if let attachment = photoAttachment {
            let photoHeight = CGFloat(attachment.height)
            let photoWidth = CGFloat(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: работа с bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //MARK: работа с cell height
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame, attachmentFrame: attachmentFrame, bottomViewFrame: bottomViewFrame, totalHeight: totalHeight)
    }
    
    
}



