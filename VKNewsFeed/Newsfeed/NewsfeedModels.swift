//
//  NewsfeedModels.swift
//  VKNewsFeed
//
//  Created by Ramil on 02/11/2019.
//  Copyright (c) 2019 Ramil. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsfeed
        case getUser
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsfeed(feed: FeedResponse, revealedPostIds: [Int])
        case presentUserInfo(user: UserResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel)
        case displayUser(userViewModel: UserViewModel)
      }
    }
  }
}


struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}

struct FeedViewModel {
    
    struct Cell: FeedCellViewModel {
        var postId: Int
        
        // FeedCellViewModel
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}
