//
//  Follower.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 26.01.22.
//

import Foundation

struct Follower: Codable {
    var login: String
    // when JSON name is in snake_case, JSONDecoder can be specified to use camelCase instead for this parameter
    var avatarUrl: String
}
