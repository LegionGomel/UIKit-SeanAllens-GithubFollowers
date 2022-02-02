//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 2.02.22.
//

import UIKit

extension UITableView {
    
    // not used here, but can be used in future projects
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
