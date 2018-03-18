//
//  PlayerView.swift
//  Thundera
//
//  Created by Dulio Denis on 3/17/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var episodeTitleLabel: UILabel! {
        didSet {
            episodeTitleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    
    // MARK: - Player Action Methods
    
    @IBAction func playPause(_ sender: Any) {
        
    }
    
    @IBAction func dismissPlayer(_ sender: Any) {
        removeFromSuperview()
    }
}
