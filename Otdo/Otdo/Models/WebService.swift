//
//  WebService.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import Foundation

class WebService {
    func currentWeatherfetchData(url: String) async throws -> CurrentWeather? {
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
        return result
    }
    
    func hourlyWeatherfetchData(url: String) async throws -> HourlyWeather? {
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(HourlyWeather.self, from: data)
        return result
    }
}
