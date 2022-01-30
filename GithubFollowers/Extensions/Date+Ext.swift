//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 30.01.22.
//

import Foundation

extension Date {
    func convetToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
