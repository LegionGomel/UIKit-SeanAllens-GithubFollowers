//
//  UIview+Ext.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 2.02.22.
//

import UIKit

extension UIView {
    
    // variadic parameter (can pass any number of subviews
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
