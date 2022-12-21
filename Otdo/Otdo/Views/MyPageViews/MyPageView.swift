//
//  MyPageView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI

struct MyPageView: View {
    @State private var segmentationSelection: PostSection = .myPost
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var viewRouter: ViewRouter

    var userNickName: String = "Empty"
    let userEmail: String = "Empty"

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil)
    ]
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Circle()
                        .frame(width: 80)
                    VStack(alignment: .leading){
                        Text("\(userInfoStore.users[0].nickName)")
                            .font(.title2)
                            .fontWeight(.heavy)
                        Text("\(userInfoStore.users[0].email)")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                NavigationLink(destination: Text("프로필 편집 화면")){
                    Text("프로필 편집")
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                        .frame(width: 330, height: 45)
                        .background {
                            RoundedRectangle(cornerRadius: 17, style: .continuous)
                                .stroke(.gray, lineWidth: 2)
                        }
                }
                
                Divider()
                    .padding()
                Picker("게시물 선택", selection: $segmentationSelection){
                    ForEach(PostSection.allCases, id:\.self) { option in
                        Text(option.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 10)
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 8,
                        pinnedViews: [],
                        content:  {
                            ForEach(0..<30) { index in RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                                    .frame(width:160, height: 250)
                            }
                        }
                    )
                }
            }
            .toolbar{
                Button(action: {
                    userInfoStore.logout()
                    viewRouter.currentPage = .loginView
                }){
                    Text("Logout")
                }
            }
            .padding()
        }
    }
}
enum PostSection: String, CaseIterable {
    case myPost = "내가 쓴 게시물"
    case bookmarks = "북마크 한 게시물"
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
