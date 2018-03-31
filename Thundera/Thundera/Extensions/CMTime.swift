//
//  CMTime.swift
//  Thundera
//
//  Created by Dulio Denis on 3/31/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
