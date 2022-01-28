//
//  User.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 26.01.22.
//

import Foundation


struct User: Codable {
    let login: String
    let avatarUrl: String
    // user might not put real username and location, and if this is not optional - app will crash
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGistsL: Int
    let htmlURL: String
    let following: Int
    let followers: Int
    let createdAt: String
}
