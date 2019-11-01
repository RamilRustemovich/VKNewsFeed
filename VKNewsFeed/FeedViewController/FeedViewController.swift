//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Ramil on 22/09/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService: Networking = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3725763559, green: 0.679697752, blue: 0.9031428695, alpha: 1)
        
        let params = ["filters": "post, photo"]
        networkService.request(path: API.newsFeedPath, parameters: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json)")
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
