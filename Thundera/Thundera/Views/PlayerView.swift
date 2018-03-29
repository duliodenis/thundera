//
//  PlayerView.swift
//  Thundera
//
//  Created by Dulio Denis on 3/17/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit
import AVKit

class PlayerView: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.layer.cornerRadius = 10
            episodeImageView.clipsToBounds = true
            let scale:CGFloat = 0.7
            episodeImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    @IBOutlet weak var episodeTitleLabel: UILabel! {
        didSet {
            episodeTitleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            
            playEpisode()
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let time = CMTimeMake(1, 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times,
                                       queue: .main) {
                                        self.enlargeEpisodeImageView()
        }
    }
    
    
    // MARK: - Player Action Methods
    
    fileprivate func playEpisode() {
        print("Tring to print url at \(episode.streamUrl)")
        guard let url = URL(string: episode.streamUrl) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    @IBAction func playPause(_ sender: Any) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    fileprivate func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.episodeImageView.transform = .identity
        })
    }
    
    @IBAction func dismissPlayer(_ sender: Any) {
        removeFromSuperview()
    }
}
