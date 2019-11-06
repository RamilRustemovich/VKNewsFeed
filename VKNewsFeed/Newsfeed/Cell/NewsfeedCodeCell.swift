//
//  NewsfeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Ramil on 06/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    // First Layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // Second Layer
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
       let lbl = UILabel()
        //lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        lbl.numberOfLines = 0
        lbl.font = Constants.postLabelFont
        return lbl
    }()
    
    let postImageView: WebImageView = {
       let imgView = WebImageView()
        //imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1) // оставить
        return imgView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    // init and Set
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.overlayFirstLayer()
        self.overlaySecondLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FeedCellViewModel) {
//        self.iconImageView.set(imageURL: viewModel.iconUrlString)
//        self.nameLabel.text = viewModel.name
//        self.dateLabel.text = viewModel.date
//        self.postLabel?.text = viewModel.text
//        self.likesLabel.text = viewModel.likes
//        self.commentsLabel.text = viewModel.comments
//        self.sharesLabel.text = viewModel.shares
//        self.viewsLabel.text = viewModel.views
//        
        self.postLabel.frame = viewModel.sizes.postLabelFrame
        self.postImageView.frame = viewModel.sizes.attachmentFrame
        self.bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachment {
           // self.postImageView.set(imageURL: photoAttachment.photoUrlString)
            self.postImageView.isHidden = false
        } else {
            self.postImageView.isHidden = true
        }
    }
    
    
    // constraints
    private func overlaySecondLayer() {
        self.cardView.addSubview(self.topView)
        self.cardView.addSubview(self.postImageView)
        self.cardView.addSubview(self.postLabel)
        self.cardView.addSubview(self.bottomView)
        
        // topView constraint
        self.topView.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 8).isActive = true
        self.topView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 8).isActive = true
        self.topView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -8).isActive = true
        self.topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
         // postImageView constraint
        
         // postLabel constraint
        
         // bottomView constraint
        
        
    }
    
    
    private func overlayFirstLayer() {
        self.addSubview(self.cardView)
        self.cardView.fillSuperview(padding: Constants.cardInsets)
    }
}
