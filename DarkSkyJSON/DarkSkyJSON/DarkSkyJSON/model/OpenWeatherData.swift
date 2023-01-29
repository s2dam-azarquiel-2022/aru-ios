//
//  Result.swift
//  DarkSkySAX
//
//  Created by Usuario on 24/01/2023.
//  Copyright © 2023 Azarquiel. All rights reserved.
//

import UIKit

class OpenWeatherData: Codable {
    let data: [TimeData]?

    private enum CodingKeys: String, CodingKey {
        case data = "list"
    }
}

struct TimeData: Codable {
    let date: String?
    let info: Info?
    let weather: [Weather]?
    let precipitation: Float?
    let wind: Wind?

    private enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case info = "main"
        case weather = "weather"
        case precipitation = "pop"
        case wind = "wind"
    }
}

struct Info: Codable {
    let tempMin: Float?
    let tempMax: Float?
    let humidity: Int?
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity = "humidity"
    }
}

struct Weather: Codable {
    let icon: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case icon = "icon"
        case description = "description"
    }
}

struct Wind: Codable {
    let speed: Float?
    
    private enum CodingKeys: String, CodingKey {
        case speed = "speed"
    }
}
