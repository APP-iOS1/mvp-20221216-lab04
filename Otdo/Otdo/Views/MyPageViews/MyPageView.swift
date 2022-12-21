//
//  MyPageView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI
import FirebaseAuth

struct MyPageView: View {
    @State private var segmentationSelection: PostSection = .myPost
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var viewRouter: ViewRouter

    var userNickName: String = "Empty"
    let userEmail: String = "Empty"

    @State private var myPost: [Post] = []
    
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
                            ForEach(Array(myPost.enumerated()), id: \.offset) { (index, post) in
                                NavigationLink(destination: PostDetailView(post: post, index: index)) {
                                    OOTDPostView(post: post)
                                }
                                .foregroundColor(.black)
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
        .onAppear {
            myPost.removeAll()
            for post in postStore.posts {
                if post.userId == Auth.auth().currentUser?.uid {
                    myPost.append(post)
                }
            }
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
