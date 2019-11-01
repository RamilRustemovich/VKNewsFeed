//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Ramil on 22/09/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3725763559, green: 0.679697752, blue: 0.9031428695, alpha: 1)
        
        self.fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
        }
        
        
    }
    

    // MARK: - Navigation

 

}
