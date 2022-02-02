//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 28.01.22.
//

import UIKit

enum UIHelper {
    
    // layout tuning for collectionView
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // total width of the screen
        let width = view.bounds.width
        // ui edge insets
        let padding:CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2) // two minimum spacing for three columns
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
