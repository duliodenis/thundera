//
//  EpisodeCell.swift
//  Thundera
//
//  Created by Dulio Denis on 3/13/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
        }
    }
    
}
