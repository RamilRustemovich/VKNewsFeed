//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}


struct NetworkDataFetcher: DataFetcher {
    
    private let networking: Networking
    private let authService: AuthService
    
    init(networking: Networking, authService: AuthService = AppDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    //MARK: - methods
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
          let params = ["filters": "post, photo"]
        self.networking.request(path: API.newsFeedPath, parameters: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = self.authService.userId else { return }
          let params = ["fields": "photo_100", "user_ids": userId]
        self.networking.request(path: API.userPath, parameters: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
