//
//  String.swift
//  Thundera
//
//  Created by Dulio Denis on 3/15/18.
//  Copyright © 2018 ddApps. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        // to prevent ATP Errors - if http - switch to https
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
