//
//  SearchController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/10/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    let podcasts = [
        Podcast(name: "Syntax - Tasty Web Development Treats", artistName: "Wes Bos & Scott Tolinski"),
        Podcast(name: "The /Filmcast", artistName: "David Chen, Devindra Hardawar, and Jeff Cannata"),
        Podcast(name: "Podcast14", artistName: "Podcast14 Team")
    ]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.textLabel?.text = "\(podcast.name)\nby \(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        
        return cell
    }
}
