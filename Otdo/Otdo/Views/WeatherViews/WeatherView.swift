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
    let url: String = "https://api.openweathermap.org/data/2.5/weather?lat=37.5683&lon=126.9778&appid=3f9b06947acddcef370b23a5aaaae195"
    @State var isShowRegionSheet = false
    @State var isShowDetailWeatherSheet = false
    
    let ranks = ["homeRank", "homeRank", "homeRank", "homeRank", "homeRank"]
    
    var body: some View {
        
        VStack {
            // 현재 지역 및 지역 선택 버튼
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.gray.opacity(0.2))
                    
                VStack {
                    Button(action: {
                        isShowRegionSheet.toggle()
                    }) {
                        HStack {
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
                            Text("21°")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("비소식 없이 화창함")
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Text("최고 23°/최저 18°")
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
