//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Ramil on 23/09/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//
import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}



final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams            = parameters
        allParams["acces_token"] = token
        allParams["v"]           = API.version
        guard let url = self.url(from: path, parameters: allParams) else { return }
        let request = URLRequest(url: url)
        let task = self.createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url
    }

}
