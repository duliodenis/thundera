//
//  EpisodesController.swift
//  Thundera
//
//  Created by Dulio Denis on 3/12/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import UIKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
