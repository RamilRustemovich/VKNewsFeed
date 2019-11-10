//
//  NewsfeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Ramil on 06/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    // First Layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // Second Layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
       let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        lbl.numberOfLines = 0
        lbl.font = Constants.postLabelFont
        return lbl
    }()
    
    let moreTextButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        btn.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.contentVerticalAlignment = .center
        btn.setTitle("Показать полностью...", for: .normal)
        return btn
    }()
    
    let postImageView: WebImageView = {
       let imgView = WebImageView()
        imgView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imgView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Third Layer on the TopView
    let iconImageView: WebImageView = {
        let imgView = WebImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    // Third Layer on the bottomView
    let likesView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Fourth Layer on the bottomView
    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        self.iconImageView.set(imageURL: nil)
        self.postImageView.set(imageURL: nil)
    }
    
    //MARK: init and Set
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
        self.iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        self.iconImageView.clipsToBounds = true
        
        self.overlayFirstLayer()
        self.overlaySecondLayer()
        self.overlayThirdLayerOnTopView()
        self.overlayThirdLayerOnBottomView()
        self.overlayFourthLayerOnBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FeedCellViewModel) {
        self.iconImageView.set(imageURL: viewModel.iconUrlString)
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.postLabel.text = viewModel.text
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.sharesLabel.text = viewModel.shares
        self.viewsLabel.text = viewModel.views
        // frames:
        self.postLabel.frame = viewModel.sizes.postLabelFrame
        self.postImageView.frame = viewModel.sizes.attachmentFrame
        self.bottomView.frame = viewModel.sizes.bottomViewFrame
        self.moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            self.postImageView.set(imageURL: photoAttachment.photoUrlString)
            self.postImageView.isHidden = false
        } else {
            self.postImageView.isHidden = true
        }
    }
    
    
    //MARK: constraints
    private func overlayFourthLayerOnBottomView() {
        self.likesView.addSubview(self.likesImage)
        self.likesView.addSubview(self.likesLabel)
        self.commentsView.addSubview(self.commentsImage)
        self.commentsView.addSubview(self.commentsLabel)
        self.sharesView.addSubview(self.sharesImage)
        self.sharesView.addSubview(self.sharesLabel)
        self.viewsView.addSubview(self.viewsImage)
        self.viewsView.addSubview(self.viewsLabel)
    
        self.helpInFourthLayer(view: self.likesView, imageView: self.likesImage, label: self.likesLabel)
        self.helpInFourthLayer(view: self.commentsView, imageView: self.commentsImage, label: self.commentsLabel)
        self.helpInFourthLayer(view: self.sharesView, imageView: self.sharesImage, label: self.sharesLabel)
        self.helpInFourthLayer(view: self.viewsView, imageView: self.viewsImage, label: self.viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).activate
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).activate
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).activate
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).activate
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).activate
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).activate
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).activate
    }
    
    private func overlayThirdLayerOnBottomView() {
        self.bottomView.addSubview(self.likesView)
        self.bottomView.addSubview(self.commentsView)
        self.bottomView.addSubview(self.sharesView)
        self.bottomView.addSubview(self.viewsView)
        
        // likesView constraints
        self.likesView.anchor(top: self.bottomView.topAnchor, leading: self.bottomView.leadingAnchor, bottom: self.bottomView.bottomAnchor, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: 0))
        
        // commentsView constraints
        self.commentsView.anchor(top: self.bottomView.topAnchor, leading: self.likesView.trailingAnchor, bottom: self.bottomView.bottomAnchor, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: 0))
        
        // sharesView constraints
        self.sharesView.anchor(top: self.bottomView.topAnchor, leading: self.commentsView.trailingAnchor, bottom: self.bottomView.bottomAnchor, trailing: nil, size: CGSize(width: Constants.bottomViewViewWidth, height: 0))
        
        // viewsView constraints
        self.viewsView.anchor(top: self.bottomView.topAnchor, leading: nil, bottom: self.bottomView.bottomAnchor, trailing: self.bottomView.trailingAnchor, size: CGSize(width: Constants.bottomViewViewWidth, height: 0))
    }
    
    
    private func overlayThirdLayerOnTopView() {
        self.topView.addSubview(self.iconImageView)
        self.topView.addSubview(self.nameLabel)
        self.topView.addSubview(self.dateLabel)
        
        // iconImageView constraints
        self.iconImageView.topAnchor.constraint(equalTo: self.topView.topAnchor).isActive = true
        self.iconImageView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel constraints
        self.nameLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 8).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -8).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.topView.topAnchor, constant: 2).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
         // dateLabel constraints
        self.dateLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 8).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -8).isActive = true
        self.dateLabel.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: -2).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    private func overlaySecondLayer() {
        self.cardView.addSubview(self.topView)
        self.cardView.addSubview(self.postImageView)
        self.cardView.addSubview(self.moreTextButton)
        self.cardView.addSubview(self.postLabel)
        self.cardView.addSubview(self.bottomView)
        
        // topView constraint
        self.topView.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 8).activate
        self.topView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 8).activate
        self.topView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -8).activate
        self.topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).activate
         // postImageView constraint - calculating
         // postLabel constraint - calculating
         // bottomView constraint - calculating
    }
    
    private func overlayFirstLayer() {
        self.addSubview(self.cardView)
        self.cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    
    @objc private func moreTextButtonTouch() {
        self.delegate?.revealPost(for: self)
    }
}
