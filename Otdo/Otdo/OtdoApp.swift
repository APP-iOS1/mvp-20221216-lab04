//
//  OtdoApp.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct OtdoApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    @StateObject var userInfoStore = UserInfoStore()


  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
          if userInfoStore.currentUser == nil {
              ContentView().environmentObject(viewRouter).environmentObject(userInfoStore)
          } else {
              MainView().environmentObject(viewRouter).environmentObject(userInfoStore)
          }
      }
    }
  }
}
