//
//  TitleView.swift
//  VKNewsFeed
//
//  Created by Ramil on 11/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

final class TitleView: UITextField {
    
    private var textField = InsetableTextField()
    
    private var myAvatarView: WebImageView = {
        let imgView = WebImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        //imgView.backgroundColor = .clear
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myAvatarView)
        addSubview(textField)
        self.makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(userViewModel: TitleViewViewModel) {
        self.myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    
    private func makeConstraints() {
        // myAvatarView constraints:
        self.myAvatarView.anchor(top: self.topAnchor,
                                 trailing: self.trailingAnchor,
                                 padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
        
        self.myAvatarView.heightAnchor.constraint(equalTo: self.textField.heightAnchor, multiplier: 1).activate
        self.myAvatarView.widthAnchor.constraint(equalTo: self.textField.heightAnchor, multiplier: 1).activate
        // textField constraints:
        self.textField.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.myAvatarView.leadingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    }
    
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.myAvatarView.layer.masksToBounds = true
        self.myAvatarView.layer.cornerRadius = self.myAvatarView.frame.width / 2
    }
    
}

