//
//  SearchController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/10/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit
import Alamofire

class SearchController: UITableViewController {
    
    var podcasts: [Podcast] = Array()
    
    let cellID = "cellID"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    // MARK: - Setup Methods
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        // Register the cell class
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let podcast = podcasts[indexPath.row]
        
        cell.imageView?.image = #imageLiteral(resourceName: "podcast-default-cover-art")
        // Use the Nil-Coalescing Operator
        cell.textLabel?.text = "\(podcast.trackName ?? "")\nby \(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        
        return cell
    }
}

// MARK: - Search Bar Delegate Methods
extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText,
                          "media": "podcast"]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseData { (dataResponse) in
                            if let err = dataResponse.error {
                                print("Failed to contact server: \(err.localizedDescription)")
                                return
                            }
                            
                            guard let data = dataResponse.data else { return }
                            
                            do {
                                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                                self.podcasts = searchResult.results
                                self.tableView.reloadData()
                                
                            } catch let decodeError {
                                print("Failed to decode: \(decodeError.localizedDescription)")
                            }
                            
        }
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
}
