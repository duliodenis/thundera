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
        
        // to prevent ATP Errors - if http - switch to https
        let secureFeedURL = feedURL.contains("https") ? feedURL : feedURL.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedURL) else { return }
        let parser = FeedParser(URL: url)
        
        parser?.parseAsync(result: { (result) in
            switch result {
            case let .rss(feed):
                let podcastImageUrl = feed.iTunes?.iTunesImage?.attributes?.href
                var episodes = [Episode]()
                
                feed.items?.forEach({ (feedItem) in
                    var episode = Episode(feedItem: feedItem)
                    
                    // if the episode image is nil use the podcast image
                    if episode.imageUrl == nil {
                        episode.imageUrl = podcastImageUrl
                    }
                    episodes.append(episode)
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
                
            default:
                print("something else")
            }
        })
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
