//
//  PodcastCell.swift
//  Thundera
//
//  Created by Dulio Denis on 3/11/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            // Image Fetching
            guard let url = URL(string: podcast.artworkUrl600 ?? "") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.podcastImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
