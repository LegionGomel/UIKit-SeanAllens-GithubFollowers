//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 28.01.22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
