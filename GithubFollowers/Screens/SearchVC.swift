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
    
    var isUserNameEntered: Bool { !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        // set adaptive background color(dark for dark mode end so on)
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         Because of viewDidLoad isn't calls when screen go back,
         we need to hide nav bar every time, when view shows on screen
         */
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func pushFollowerListVC() {
        // basic text validation
        guard isUserNameEntered else {
            // func made via extension to present alert if username is empty
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username we need to look for 😀", buttonTitle: "Ok")
            return
        }
        
        // create object
        let followerListVC = FollowerListVC()
        // cofigure data that you want to pass
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        // push VC onto the stack
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    //MARK: - UI functions
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            // pin top side of textField to bottom part of imageView at 48 points
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // for trailing anchor we need to use negative points
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        // adding a target, whenever we tap the followers button, pushFollowerListVC is going to be called (or when we tap "go" button)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // pin button relative to bottom safe area of view
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - UITextFieldDelegate extension

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
