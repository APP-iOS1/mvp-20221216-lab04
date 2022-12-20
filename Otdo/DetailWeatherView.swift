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
    let hourlyWeatherURl = "api.openweathermap.org/data/2.5/forecast?lat=35.21288&lon=128.98061&appid=3f9b06947acddcef370b23a5aaaae195"
    
    var week = ["화", "수", "목", "금", "토", "일", "월"]
    var weatherImages = ["sun.max.fill", "cloud.sun.fill", "cloud.rain.fill", "sun.max.fill", "cloud.sun.fill", "sun.max.fill", "sun.max.fill"]
    
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0))
            VStack(alignment: .leading) {
//                ScrollView(.horizontal) {
//                    HStack(spacing: 5) {
//                        ForEach(0..<weatherImages.count, id: \.self) { index in
//                            VStack {
//                                Text("오후 \((index+1)*3)시")
//                                    .font(.headline)
//                                Image(systemName: weatherImages[index])
//                                    .renderingMode(.original)
//                                    .font(.title)
//                                Text("23°")
//                                    .font(.subheadline)
//                            }
//                        }
//                    }
//                }
//                .scrollIndicators(.hidden)
                
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
                            Text("\(Int(weatherStore.weatherInfo?.wind?.speed ?? 0))m/s")
                        }
                        
                        VStack {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("습도")
                                .font(.headline)
                            Text("\(weatherStore.weatherInfo?.clouds?.percentage ?? 0)%")
                        }
                        
                        VStack {
                            Image(systemName: "umbrella.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("1시간 강수량")
                                .font(.headline)
                            Text("\(Int(weatherStore.weatherInfo?.rain?.lastHour ?? 0))%")
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
                            Text("\(weatherStore.weatherInfo?.sys?.sunrise ?? 0)")
                            Image(systemName: "sunrise.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.yellow)
                        }
                    
                        VStack {
                            Text("일몰")
                                .font(.headline)
                            Text("\(weatherStore.weatherInfo?.sys?.sunset ?? 0)")
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
                weatherStore.weatherInfo = try await webService.fetchData(url: url ?? "")
            }
        }
    }
    
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView(url: "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=da7d02bbb56edde56edb8830de8261df")
    }
}
