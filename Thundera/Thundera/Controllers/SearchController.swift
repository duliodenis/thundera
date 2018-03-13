//
//  SearchController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/10/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    var podcasts = [Podcast]()
    
    let cellID = "cellID"
    let cellHeight: CGFloat = 132 // 100 (ImageView) + 16 (top) + 16 (bottom)
    let headerHeight: CGFloat = 250
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    // MARK: - Setup Methods
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        // remove horizontal lines from the tabvleView
        tableView.separatorStyle = .none
        
        // Register the cell nib
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
        episodesController.podcast = podcasts[indexPath.row]
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PodcastCell
        cell.podcast = podcasts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nullLabel = UILabel()
        nullLabel.text = "Please enter a search term to discover new podcasts."
        nullLabel.numberOfLines = 2
        nullLabel.textAlignment = .center
        nullLabel.font = UIFont(name: "Aileron-SemiBold", size: 22)
        nullLabel.textColor = UIColor.purpleThunder
        return nullLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return podcasts.count == 0 ? headerHeight : 0
    }
}

// MARK: - Search Bar Delegate Methods
extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(using: searchText) { (searchResults) in
            self.podcasts = searchResults
            self.tableView.reloadData()
        }
    }
    
}
