//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 25.01.22.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        // view.bounds - fill up the whole view with collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        // pink for debugging
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    // layout tuning for collectionView
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
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
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
                
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happen", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
