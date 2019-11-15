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
   
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
        case .getNewsfeed:
            self.service?.getFeed(completion: { [weak self] (revealedPostIds, feedResponse) in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            })
        case .getUser:
            self.service?.getUser(completion: { [weak self] (userResponse) in
                self?.presenter?.presentData(response: .presentUserInfo(user: userResponse))
            })
        case .revealPostIds(let postId):
            self.service?.revealedPostIds(forPostId: postId, completion: { [weak self] (revealedPostIds, feedResponse) in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            self.service?.getNextBatch(completion: { [weak self] (revealedPostIds, feedResponse) in
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse, revealedPostIds: revealedPostIds))
            })
        }
        
        
    }
    
   
    
}
