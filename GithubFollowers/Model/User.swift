//
//  User.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 26.01.22.
//

import Foundation


struct User: Codable {
    var login: String
    var avatarUrl: String
    // user might not put real username and location, and if this is not optional - app will crash
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGistsL: Int
    var htmlURL: String
    var following: Int
    var followers: Int
    var createdAt: String
}
