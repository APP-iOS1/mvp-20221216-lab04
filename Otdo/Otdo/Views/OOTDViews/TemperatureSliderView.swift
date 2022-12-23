//
//  TemperatureSliderView.swift
//  Otdo
//
//  Created by 이민경 on 2022/12/22.
//

import SwiftUI

struct TemperatureSliderView: View {
    @EnvironmentObject var postStore: PostStore
    @ObservedObject var slider = CustomSlider(start: -30, end: 50)
    
    @Binding var lowTemp: Double
    @Binding var highTemp: Double
    
    var body: some View {
        VStack{
            HStack{
                Text("온도 선택")
                    .font(.title3)
                    .bold()
                Spacer()
                Text("\(Int(lowTemp))℃ ~ \(Int(highTemp))℃")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
            }
            .padding(.horizontal, 40)
            //Slider
            SliderView(slider: slider)
                .padding(.vertical)
            HStack{
                Text("\(Int(slider.valueStart))℃")
                    .fontWeight(.semibold)
                Spacer()
                Text("\((Int(slider.valueStart) + Int(slider.valueEnd)) / 2)℃")
                    .fontWeight(.semibold)
                Spacer()
                Text("\(Int(slider.valueEnd))℃")
                    .fontWeight(.semibold)
            }
            .offset(y: -5)
            .padding(.horizontal)
            Button {
                postStore.fetchPostByTemperature(lowTemperature: slider.lowHandle.currentValue, highTemperature: slider.highHandle.currentValue)
            } label: {
                Text("설정")
                    .foregroundColor(Color.white)
                    .padding(10)
            }
            .background(.black)
            .cornerRadius(10)
            .padding(.leading, 10)
        }
        .onChange(of: slider.lowHandle.currentValue) { newValue in
            lowTemp = slider.lowHandle.currentValue
        }
        .onChange(of: slider.highHandle.currentValue) { newValue in
            highTemp = slider.highHandle.currentValue
        }
    }
}

struct SliderView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth)
            .fill(Color.gray.opacity(0.2))
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    //Path between both handles
                    SliderPathBetweenView(slider: slider)
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle)
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle)
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                }
            )
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    
    var body: some View {
        Circle()
            .frame(width: handle.diameter, height: handle.diameter)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 0)
            .scaleEffect(handle.onDrag ? 1.3 : 1)
            .contentShape(Rectangle())
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y)
    }
}

struct SliderPathBetweenView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        Path { path in
            path.move(to: slider.lowHandle.currentLocation)
            path.addLine(to: slider.highHandle.currentLocation)
        }
        .stroke(Color.gray, lineWidth: slider.lineWidth)
    }
}


//struct TemperatureSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        TemperatureSliderView()
//    }
//}
//
