//
//  MainView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        TabView {
            WeatherView()
                .environmentObject(LocationManager())
                .tabItem {
                    VStack{
                        Image(systemName: "cloud.sun")
                        Text("Weather")
                    }
                }
            OOTDView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.star")
                        Text("OOTD")
                    }
                }
            MyPageView()
                .tabItem {
                    VStack{
                        Image(systemName: "person.icloud")
                        Text("My Page")
                    }
                }
        }
        .onAppear {
            postStore.fetchPost()
            userInfoStore.fetchUser()
            for post in postStore.posts {
                postStore.retrievePhotos(post)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
