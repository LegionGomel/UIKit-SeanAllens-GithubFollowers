//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 25.01.22.
//

import UIKit

class SearchVC: UIViewController {
    
    
    // create items that will be onscreen
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        // set adaptive background(dark for dark mode end so on)
        view.backgroundColor = .systemBackground
        configureLogoImageView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         Because of viewDidLoad isn't calls when screen go back,
         we need to hide nav bar every time, when view shows on screen
         */
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImageView() {
        /*
         this line of code is like you drag imageView from library onto
         storyboard and drop it in
         */
        view.addSubview(logoImageView)
        // because this is not custom UIImageVIew (as GFButton for example), we need to add this code here.
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")! // stringly-typed. can have error here. We can have it as a constant
        
        // here we add constraints. safeAreaLayoutGuide represents safe area from storyboards
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
