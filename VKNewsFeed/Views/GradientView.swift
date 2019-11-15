//
//  GradientView.swift
//  VKNewsFeed
//
//  Created by Ramil on 16/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation
import UIKit

final class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            self.setupGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            self.setupGradientColors()
        }
    }
    private let gradientLAyer = CAGradientLayer()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupGradient()
    }
    
    //MARK: Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLAyer.frame = self.bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(self.gradientLAyer)
        self.setupGradientColors()
        self.gradientLAyer.startPoint = CGPoint(x: 0.5, y: 0)
        self.gradientLAyer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGradientColors() {
        guard let startColor = self.startColor, let endColor = self.endColor else { return }
        self.gradientLAyer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
}
