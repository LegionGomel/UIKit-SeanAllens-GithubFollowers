//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 27.01.22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder

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
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) {[weak self] (image) in
            guard self == self else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
