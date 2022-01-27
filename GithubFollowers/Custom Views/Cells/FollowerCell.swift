//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 27.01.22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // as in storyboard we use reusable ID, we need specify it here, in code
    static let reuseID = "FollowerCell"
    
    let avatarImageView = UIImageView()
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
}
