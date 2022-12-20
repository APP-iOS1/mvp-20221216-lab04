//
//  ContentView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI
/// 회원가입 및 로그인 기능 사용을 위한 라이브러리 추가
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var body: some View {
        switch viewRouter.currentPage {
        case .registerView:
            RegisterView()
        case .loginView:
            LoginView()
        case .mainView:
            MainView()
        }
    }
}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
