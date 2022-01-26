//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 26.01.22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() { }
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + ":\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "this username created invalid request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete your request")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "invalid response from the server")
                return
            }
            
            guard let data = data else {
                completed(nil, "the data received from the server is invalid")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // because of GitHub uses snake case, we need this option for decoder
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "the data received from the server is invalid")
                
            }


        }
        
        task.resume()
    }
}
