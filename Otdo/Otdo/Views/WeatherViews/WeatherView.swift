//
//  WeatherView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherStore: WeatherStore = WeatherStore()
    var webService: WebService = WebService()
    let url: String = "https://api.openweathermap.org/data/2.5/weather?lat=35.21288&lon=128.98061&appid=3f9b06947acddcef370b23a5aaaae195"
    @State var isShowRegionSheet = false
    @State var isShowDetailWeatherSheet = false
    
    let ranks = ["homeRank", "homeRank", "homeRank", "homeRank", "homeRank"]
    
    var body: some View {
        // 현재 온도 및 소수점 자르기
        let temp: String = String(format: "%.1f", (weatherStore.weatherInfo?.main?.temp ?? 0) - 273.15)
        // 최저 온도 및 소수점 자르기
        let tempMin: String = String(format: "%.1f", (weatherStore.weatherInfo?.main?.temp_min ?? 0) - 273.15)
        // 최고 온도 및 소수점 자르기
        let tempMax: String = String(format: "%.1f", (weatherStore.weatherInfo?.main?.temp_max ?? 0) - 273.15)
        
        // 현재 날씨
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray.opacity(0.2))
                    
                VStack {
                    // 지역 버튼
                    Button(action: {
                        isShowRegionSheet.toggle()
                    }) {
                        HStack {
                            // 현재 위치
                            Text("서울시 강서구")
                                .font(.title)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.down")
                                .font(.title2)
                        }
                        .foregroundColor(.black)
                    }
                    
                    .sheet(isPresented: $isShowRegionSheet) {
                        SelectRegionView()
                            .presentationDetents([.medium])
                    }
                    
                    // 현재 날씨 표시 및 상세 날씨 보기로 이동
                    Button(action: {
                        isShowDetailWeatherSheet.toggle()
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "sun.max.fill")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                            Text("\(temp)°")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("비소식 없이 화창함")
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Text("최고 \(tempMax)° / 최저 \(tempMin)°")
                                .font(.title3)
                        }
                        .foregroundColor(.black)
                        
                    }
                    .sheet(isPresented: $isShowDetailWeatherSheet) {
                        DetailWeatherView()
                    }
                }

                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 30)
       
            // TOP 10
            VStack(alignment: .leading) {
                Text("TOP 10")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(ranks, id: \.self) { rank in
                            Image(rank)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 15)
            .padding(.leading, 30)
            
        }
        .onAppear{
            Task {
                weatherStore.weatherInfo = try await webService.fetchData(url: url)
            }
            
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
