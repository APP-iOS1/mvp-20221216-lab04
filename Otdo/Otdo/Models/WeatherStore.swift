//
//  WeatherStore.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import Foundation

class WeatherStore: ObservableObject {
    @Published var weatherInfo: Weather?
//    init(weatherInfo: Main) {
//        self.weatherInfo = weatherInfo
//    }
}
