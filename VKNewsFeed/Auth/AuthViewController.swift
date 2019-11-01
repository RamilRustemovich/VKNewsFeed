//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Ramil on 20/09/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.authService = AppDelegate.shared().authService
    }
    
    @IBAction func signInTouch() {
        self.authService.wakeUpSession()
    }
    
}
