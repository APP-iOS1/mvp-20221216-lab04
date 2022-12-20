//
//  DetailWeather.swift
//  Otdo
//
//  Created by hyemi on 2022/12/19.
//

import SwiftUI

struct SelectRegionView: View {
    let regions: [String] = ["서울", "경기", "인천", "대전", "충북", "충남", "부산", "대구", "경북", "경남", "울산", "광주"]
   // let cities: [String: [String]] = ["경기": ["수원", "성남", "고양", "용인"]]
    @Binding var selectRegion: String?
    @Environment(\.presentationMode) var isShowRegionSheet: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            // 지역 경로
            Spacer()
            HStack {
                Text("전체 지역")
                    .font(.headline)
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // 각 지역 버튼
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(0..<regions.count, id: \.self) { index in
                        Button(action: {
                            selectRegion = regions[index]
                        }) {
                            if regions[index] == selectRegion {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.black)
                                        .frame(height: 50)
                                    Text(regions[index])
                                        .foregroundColor(.white)
                                }
                                
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                        .frame(height: 50)
                                    Text(regions[index])
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
