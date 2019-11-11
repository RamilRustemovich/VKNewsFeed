//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Ramil on 11/11/2019.
//  Copyright © 2019 Ramil. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    var response: [UserResponse]
}

struct UserResponse: Decodable {
    var photo100: String?
}
