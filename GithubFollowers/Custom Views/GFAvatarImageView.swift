//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 27.01.22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        // this need to apply corner radius to image ( without it still have sharp edges)
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
