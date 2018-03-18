//
//  Episode.swift
//  Thundera
//
//  Created by Dulio Denis on 3/13/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let author: String
    let pubDate: Date
    let description: String
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}
