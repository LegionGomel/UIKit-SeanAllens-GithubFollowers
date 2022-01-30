//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Yuri Ershov on 25.01.22.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureSearchController()
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        // view.bounds - fill up the whole view with collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        // delegate to use text in search bar in custom function
        searchController.searchResultsUpdater = self
        // delegate to append function to cancel button
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
        // always show search bar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
        
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            /*
             we can unwrap [weak self] or write self? optional (there is also
             [unowned self] that already unwrap optional, but little more dangerous
             */
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "this user doesn't have any followers. Go follow them 😀."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
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
    func updateData(on followers: [Follower]) {
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
    
    @objc func addButtonTapped() {
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        // filtering an array of followers by text from searchbar
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())
        }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
