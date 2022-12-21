//
//  WeatherStore.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import Foundation

class WeatherStore: ObservableObject {
    @Published var currentWeatherInfo: CurrentWeather?
//    init(weatherInfo: CurrentWeather?) {
//        self.weatherInfo = weatherInfo
//    }
    
    @Published var hourlyWeatherInfo: HourlyWeather?
}
