//
//  EpisodesController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/12/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var episodes = [Episode]()
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes() {
        guard let feedURL = podcast?.feedUrl else { return }
        APIService.shared.fetchEpisodes(feedURL: feedURL) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    // MARK: - Helper Method
    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    
    // MARK: TableView Delegate Methods
    fileprivate let cellID = "cellID"
    fileprivate let cellHeight: CGFloat = 132 // 100 (ImageView) + 16 (top) + 16 (bottom)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        let window = UIApplication.shared.keyWindow
        let playerView = PlayerView.initFromNib()
        playerView.episode = episode
        playerView.frame = self.view.frame
        window?.addSubview(playerView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EpisodeCell
        cell.episode = episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
