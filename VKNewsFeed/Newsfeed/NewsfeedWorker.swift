//
//  NewsfeedWorker.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright (c) 2019 Ramil. All rights reserved.
//

import UIKit

class NewsfeedService {

    private var authService: AuthService
    private var networking: Networking
    private var dataFetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = AppDelegate.shared().authService
        self.networking = NetworkService(authService: self.authService)
        self.dataFetcher = NetworkDataFetcher(networking: self.networking)
    }
    
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        self.dataFetcher.getFeed(nextBatchFrom: nil) { [weak self] (feedResponse) in
            self?.feedResponse = feedResponse
            
            guard let feedResponse = self?.feedResponse, let revealedPostIds = self?.revealedPostIds  else { return }
            completion(revealedPostIds, feedResponse)
        }
    }
    
    func revealedPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        self.revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(self.revealedPostIds, feedResponse)
    }
    
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        self.dataFetcher.getUser(response: completion)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        self.newFromInProcess = self.feedResponse?.nextFrom
        self.dataFetcher.getFeed(nextBatchFrom: self.newFromInProcess) { [weak self] (feedResponse) in
            
            guard let feedResponse = feedResponse, self?.feedResponse?.nextFrom != feedResponse.nextFrom else { return }
            if self?.feedResponse == nil {
               self?.feedResponse = feedResponse
            } else {
                self?.feedResponse?.items.append(contentsOf: feedResponse.items)
                self?.feedResponse?.nextFrom = feedResponse.nextFrom
                
                var profiles = feedResponse.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter({ (oldProfile) -> Bool in
                        !feedResponse.profiles.contains(where: { $0.id == oldProfile.id })
                    })
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feedResponse.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter({ (oldGroup) -> Bool in
                        !feedResponse.groups.contains(where: { $0.id == oldGroup.id })
                    })
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
            }
            
            guard let feed = self?.feedResponse, let revealedPostIds = self?.revealedPostIds  else { return }
            completion(revealedPostIds, feed)
        }
    }
}
