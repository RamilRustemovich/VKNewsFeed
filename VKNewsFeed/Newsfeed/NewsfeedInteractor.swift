//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright (c) 2019 Ramil. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsfeed:
            self.fetcher.getFeed { [weak self] (feedResponse) in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(let postId):
            self.revealedPostIds.append(postId)
            self.presentFeed()
        case .getUser:
            self.fetcher.getUser { (userResponse) in
                self.presenter?.presentData(response: .presentUserInfo(user: userResponse))
            }
        }
        
    }
    
    private func presentFeed() {
        guard let feedResponse = self.feedResponse else { return }
        self.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse, revealedPostIds: self.revealedPostIds))
    }
    
}
