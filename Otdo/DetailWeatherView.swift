//
//  DetailWeatherView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/20.
//

import SwiftUI

struct DetailWeatherView: View {
    @ObservedObject var weatherStore: WeatherStore = WeatherStore()
    var webService: WebService = WebService()
    let url: String?
    let hourlyWeatherURl = "api.openweathermap.org/data/2.5/forecast?lat=37.54815556&lon=126.851675&appid=3f9b06947acddcef370b23a5aaaae195"
    let weatherImage: [String: String] = ["clear": "sun.max.fill", "Clouds": "cloud.fill", "Snow": "snowflake", "Mist": "cloud.fog.fill"]

    let week = ["화", "수", "목", "금", "토", "일", "월"]
    var weatherImages = ["sun.max.fill", "cloud.sun.fill", "cloud.rain.fill", "sun.max.fill", "cloud.sun.fill", "sun.max.fill", "sun.max.fill"]
    
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0))
            VStack(alignment: .leading) {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        let hourlyWeaterList = weatherStore.hourlyWeatherInfo?.list.filter{$0.dtTxt.prefix(10) == getCurrentDateTime()} ?? []
                        ForEach(0..<hourlyWeaterList.count, id: \.self) { index in
                            let temp: String = String(format: "%.1f", (hourlyWeaterList[index].main?.temp ?? 0) - 273.15)
                            VStack(spacing: 3) {
                                Text(setStringToDateFormatter(inputDate: hourlyWeaterList[index].dtTxt))
                                    .font(.headline)
                                Image(systemName: weatherImage[hourlyWeaterList[index].weather?[0].main ?? ""] ?? "sun.max.fill")
                                    .renderingMode(.original)
                                    .font(.title)
                                Text("\(temp)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(height: 120)
                    HStack(spacing: 60) {
                        VStack {
                            Image(systemName: "wind")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.gray)
                            Text("바람")
                                .font(.headline)
                            Text("\(Int(weatherStore.currentWeatherInfo?.wind?.speed ?? 0))m/s")
                        }
                        
                        VStack {
                            Image(systemName: "humidity.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("습도")
                                .font(.headline)
                            Text("\(weatherStore.currentWeatherInfo?.clouds?.percentage ?? 0)%")
                        }
                        
                        VStack {
                            Image(systemName: "umbrella.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("1시간 강수량")
                                .font(.headline)
                            Text("\(Int(weatherStore.currentWeatherInfo?.rain?.lastHour ?? 0))%")
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .frame(height: 130)
                    HStack(spacing: 100) {
                        VStack {
                            Text("일출")
                                .font(.headline)
                            Text("\(setDateFormatter(inputDate: weatherStore.currentWeatherInfo?.sys?.sunrise ?? 0))")
                            Image(systemName: "sunrise.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.yellow)
                        }
                    
                        VStack {
                            Text("일몰")
                                .font(.headline)
                            Text("\(setDateFormatter(inputDate: weatherStore.currentWeatherInfo?.sys?.sunset ?? 0))")
                            Image(systemName: "sunset.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.orange)
                        }
                    }
                }
                
                Text("주간날씨")
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(0..<week.count, id: \.self) { index in
                    HStack {
                        Text(week[index])
                            .font(.headline)
                        Image(systemName: weatherImages[index])
                            .renderingMode(.original)
                            .font(.title)
                        Text("16°/28°")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea(.all)
        .onAppear{
            Task {
                weatherStore.currentWeatherInfo = try await webService.currentWeatherfetchData(url: url ?? "")
                weatherStore.hourlyWeatherInfo = try await webService.hourlyWeatherfetchData(url: "https://api.openweathermap.org/data/2.5/forecast?q=seoul&appid=3f9b06947acddcef370b23a5aaaae195" )
            }
        }
    }
    
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter() //객체 생성
        formatter.dateStyle = .long
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    func setDateFormatter(inputDate: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH시 dd분"
        let date = Date(timeIntervalSince1970: TimeInterval(inputDate))
        return dateFormatter.string(from: date)
    }
    
    func setStringToDateFormatter(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertDate = dateFormatter.date(from: inputDate) // Date 타입으로 변환
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH시 mm분" // 2020년 08월 13일 오후 04시 30분
        myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)
        return myDateFormatter.string(from: convertDate!)
    }
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView(url: "https://api.openweathermap.org/data/2.5/weather?qlat=37.54815556&lon=126.851675&appid=3f9b06947acddcef370b23a5aaaae195")
    }
}

