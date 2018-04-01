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
        let minutes = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        var timeFormatString = String()
        
        if hours == 0 {
            timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        } else if hours > 0 && hours < 9 {
            timeFormatString = String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            timeFormatString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        return timeFormatString
    }
    
}
