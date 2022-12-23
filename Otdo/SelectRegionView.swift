//
//  DetailWeather.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import SwiftUI

struct SelectRegionView: View {
    @State private var regions: [String] = ["서울", "경기", "인천", "세종", "대전", "대구", "부산", "울산", "광주", "제주", "강원", "충북", "충남", "경북", "경남", "전북", "전남"]
    let cities: [String: [String]] = ["경기": ["수원시", "고양시", "용인시", "성남시", "화성시", "부천시", "남양주시", "안산시", "평택시", "안양시", "시흥시", "파주시", "김포시", "의정부시", "광주시", "하남시", "광명시"]]
    @Binding var selectRegion: String?
    
    @Environment(\.presentationMode) var isShowRegionSheet: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            // 지역 경로
            Spacer()
            HStack {
                Button(action: {
                    regions = ["서울", "경기", "인천", "대전", "부산", "대구", "울산", "광주", "제주"]
                    selectRegion = nil
                }) {
                    Text("전체 지역")
                        .font(.headline)
                        .foregroundColor(.black)
                }

                if cities.keys.contains(selectRegion ?? "") {
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(selectRegion ?? "")
                        .font(.headline)
                } else if cities.values.map{$0}.reduce([], +).contains(selectRegion) {
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("경기")
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // 각 지역 버튼
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach($regions, id: \.self) { $region in
                        Button(action: {
                            selectRegion = region
                            if cities.keys.contains(region) {
                                regions = cities[region] ?? []
                            }
                        }) {
                            if region == selectRegion {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.black)
                                        .frame(height: 50)
                                    Text(region)
                                        .foregroundColor(.white)
                                }
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                        .frame(height: 50)
                                    Text(region)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(3)
                    }
                }
            }
            .frame(height: 220)
            .padding()
            .scrollIndicators(.hidden)
            
            // 선택 버튼
            Button(action: {
                self.isShowRegionSheet.wrappedValue.dismiss()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(height: 60)
                    Text("선택")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRegionView(selectRegion: .constant(nil))
    }
}
