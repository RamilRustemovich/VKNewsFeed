//
//  FooterView.swift
//  VKNewsFeed
//
//  Created by Ramil on 15/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

final class FooterView: UIView {
    
    private var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(infoLabel)
        self.addSubview(loader)
        
        self.infoLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: 8, left: 20, bottom: 000, right: 20))
        self.loader.centerXAnchor.constraint(equalTo: centerXAnchor).activate
        self.loader.topAnchor.constraint(equalTo: self.infoLabel.topAnchor, constant: 8).activate
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Methods
    func showLoader() {
        self.loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        self.loader.stopAnimating()
        self.infoLabel.text = title
    }
    
    
}
