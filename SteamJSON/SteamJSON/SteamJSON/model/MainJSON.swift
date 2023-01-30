//
//  Main.swift
//  SteamJSON
//
//  Created by Usuario on 26/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class MainJSON: Codable {
    let appList: AppList?
    
    private enum CodingKeys: String, CodingKey {
        case appList = "applist"
    }
}

struct AppList: Codable {
    let apps: [App]?
    
    private enum CodingKeys: String, CodingKey {
        case apps = "apps"
    }
}

struct App: Codable {
    let id: CLong?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "appid"
        case name = "name"
    }
}
