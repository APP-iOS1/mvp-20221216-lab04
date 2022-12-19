//
//  ContentView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                WeatherView()
                    .tabItem {
                        VStack{
                            Image(systemName: "cloud.sun")
                            Text("Weather")
                        }
                    }.tag(1)
                OOTDView()
                    .tabItem {
                        VStack{
                            Image(systemName: "list.star")
                            Text("OOTD")
                        }
                    }.tag(2)
                MyPageView()
                    .tabItem {
                        VStack{
                            Image(systemName: "person.icloud")
                            Text("My Page")
                        }
                     }.tag(3)
            }
          
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
