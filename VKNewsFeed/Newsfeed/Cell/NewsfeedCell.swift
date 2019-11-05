//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String { get }
    var width: Int { get }
    var height: Int { get }
}


class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width / 2
        self.iconImageView.clipsToBounds = true
        
        self.cardView.layer.cornerRadius = 10
        self.cardView.clipsToBounds = true
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func Set(viewModel: FeedCellViewModel) {
        self.iconImageView.set(imageURL: viewModel.iconUrlString)  
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.postLabel?.text = viewModel.text
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.sharesLabel.text = viewModel.shares
        self.viewsLabel.text = viewModel.views
        if let photoAttachment = viewModel.photoAttachment {
            self.postImageView.set(imageURL: photoAttachment.photoUrlString)
            self.postImageView.isHidden = false
        } else {
            self.postImageView.isHidden = true
        }
    }
    
    
}
