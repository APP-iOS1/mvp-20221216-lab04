//
//  Weather.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import Foundation
// MARK: -- Weather
struct CurrentWeather: Codable, Identifiable {
    var name: String?
    var id: Int?
    var coord: Coordinates?
    var weather: [Conditions]?
    var main: Main?
    var visibility: Int?
    var wind: CurrentWind?
    var rain: CurrentRain?
    var snow: CurrentSnow?
    var clouds: CurrentCloud?
    var dt: Int?
    var sys: CurrentSys?
    var timezone: Int?
}

// MARK: -- Coodinates
struct Coordinates: Codable {
    var lon: Float?
    var lat: Float?
}

// MARK: -- Condition
struct Conditions: Codable, Identifiable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

// MARK: -- Main
struct Main: Codable, Hashable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var humidity: Float?
    var sea_level: Float?
    var grnd_level: Float?
}

// MARK: -- Wind
struct CurrentWind: Codable {
    var speed: Float?
    var deg: Float?
    var gust: Float?
}

// MARK: -- Rain
struct CurrentRain: Codable {
    var lastHour: Float?
    var last3Hours: Float?
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case last3Hours = "3h"
    }
}

// MARK: -- Snow
struct CurrentSnow: Codable {
    var lastHour: Float?
    var last3Hours: Float?
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case last3Hours = "3h"
    }
}

// MARK: -- Cloud
struct CurrentCloud: Codable {
    var percentage: Int?
    
    private enum CodingKeys: String, CodingKey {
        case percentage = "all"
    }
}

// MARK: -- Sys
struct CurrentSys: Codable {
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    
    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let countryCode = try? container.decode(String.self, forKey: .country) {
            country = countryCodeToFullName(code: countryCode)
        } else {
            country = nil
        }
        sunrise = try? container.decode(Int.self, forKey: .sunrise)
        sunset = try? container.decode(Int.self, forKey: .sunset)
    }
    
    func countryCodeToFullName(code: String?) -> String? {
        guard code != nil else {return nil}
        let current = Locale(identifier: "en_US")
        let country = current.localizedString(forRegionCode: code!)
        return country
    }
}

/*
 경도
 "https://api.openweathermap.org/data/2.5/weather?qlat=37.54815556&lon=126.851675&appid=3f9b06947acddcef370b23a5aaaae195"
 지역
 https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=3f9b06947acddcef370b23a5aaaae195
 */
