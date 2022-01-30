//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 30.01.22.
//

import UIKit

class GFItemInfoView: UIView {

let symbolImageVIew = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    
}
