//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 25.01.22.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var followers = [Follower]()
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
        
    func getFollowers(username: String, page: Int) {
        //showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            #warning("Call dismiss")
            /*
             we can unwrap [weak self] or write self? optional (there is also
             [unowned self] that already unwrap optional, but little more dangerous
             */
            guard let self = self else { return }
            
            switch result {
                
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happen", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    // configure data source to deal with custom cell
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            // create sell as a FollowerCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            // configure cell
            cell.set(follower: follower)
            cell.clipsToBounds = true
            return cell
        })
    }
    
    // configure data source to use snapshots of an array of followers
    // it takes a snapshot of current data is, takes snapshot of a new data and then it converges them
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // for snapshot to know about sections that we use:
        // (diffabledataSource uses snapshots to deal with data)
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        DispatchQueue.main.async {
            // applying snapshot to diffableDataSource
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // first, we need to determine scrollview height and offset of user drag when we are at the bottom of content
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        // then we do math when user has more followers and call more followers
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
