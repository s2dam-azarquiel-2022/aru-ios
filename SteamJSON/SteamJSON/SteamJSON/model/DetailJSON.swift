//
//  DetailJSON.swift
//  SteamJSON
//
//  Created by Usuario on 26/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class DetailJSON: Codable {
        let data: AppData?
        
        private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
    }

    struct AppData: Codable {
        let name: String?
        let img: String?
        let desc: String?
        
        private enum CodingKeys: String, CodingKey {
            case name = "name"
            case img = "header_image"
            case desc = "short_description"
        }
    }

