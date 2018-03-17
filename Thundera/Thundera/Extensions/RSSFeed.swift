//
//  RSSFeed.swift
//  Thundera
//
//  Created by Dulio Denis on 3/16/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        let podcastImageUrl = iTunes?.iTunesImage?.attributes?.href
        var episodes = [Episode]()
        
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            // if the episode image is nil use the podcast image
            if episode.imageUrl == nil {
                episode.imageUrl = podcastImageUrl
            }
            episodes.append(episode)
        })
        
        return episodes
    }
}
