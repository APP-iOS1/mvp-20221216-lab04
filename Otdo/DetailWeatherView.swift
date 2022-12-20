//
//  DetailWeatherView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/20.
//

import SwiftUI

struct DetailWeatherView: View {
    var week = ["화", "수", "목", "금", "토", "일", "월"]
    var weatherImages = ["sun.max.fill", "cloud.sun.fill", "cloud.rain.fill", "sun.max.fill", "cloud.sun.fill", "sun.max.fill", "sun.max.fill"]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0))
            VStack(alignment: .leading) {
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        ForEach(0..<weatherImages.count, id: \.self) { index in
                            VStack {
                                Text("오후 \((index+1)*3)시")
                                    .font(.headline)
                                Image(systemName: weatherImages[index])
                                    .renderingMode(.original)
                                    .font(.title)
                                Text("23°")
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
                            Text("2m/s")
                        }
                        
                        VStack {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("습도")
                                .font(.headline)
                            Text("45%")
                        }
                        
                        VStack {
                            Image(systemName: "umbrella.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.blue)
                            Text("1시간 강수량")
                                .font(.headline)
                            Text("101.2mm")
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
                            Text("오전 5:32")
                            Image(systemName: "sunrise.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.yellow)
                        }
                    
                        VStack {
                            Text("일몰")
                                .font(.headline)
                            Text("오후 7:35")
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
    }
}

struct DetailWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWeatherView()
    }
}
