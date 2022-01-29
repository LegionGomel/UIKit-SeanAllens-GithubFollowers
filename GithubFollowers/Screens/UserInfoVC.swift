//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 28.01.22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                    print(user)
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
