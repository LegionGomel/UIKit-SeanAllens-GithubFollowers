//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 26.01.22.
//

import Foundation

// enum with raw value ( all cases conform to one type (as opposite to associated values, where every case can have a different type)
enum ErrorMessage: String {
    
    case invalidUsername = "This username created invalid request"
    case unableToComplete = "Unable to complete your request"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "The data received from the server is invalid"

}
