//
//  PostDetailView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @State private var showingMenu: Bool = false
    @State private var showingEdit: Bool = false
    
    @State var post: Post
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Text("\(post.nickName)")
                        .bold()
                    Spacer()
                    Button {
                        showingMenu.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                    }
                }
                .padding()
                
                Image("PostDetailImage")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height * 0.45)
                    .border(.gray.opacity(1))
                    .padding(20)
                
                HStack {
                    Image(systemName: "heart.fill")
                        .padding(.leading)
                        .padding(.trailing, -5)
                    Text("1324")
                        .padding(.trailing, -5)
                    Image(systemName: "message")
                        .padding(.trailing, -5)
                    Text("26")
                    Spacer()
                    Text("서울시 중랑구")
                        .padding(.trailing)
                        .foregroundColor(.gray)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(post.nickName)")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                            .padding(.vertical, -1)
                        Text(post.content)
                            .padding(.leading)
                    }
                    Spacer()
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 44)
                        VStack(alignment: .leading) {
                            Text("민콩")
                            Text("이뿌댜앙")
                        }
                        Spacer()
                        Text("2분전")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    HStack {
                        Circle()
                            .frame(width: 44)
                        VStack(alignment: .leading) {
                            Text("민콩")
                            Text("이뿌댜앙")
                        }
                        Spacer()
                        Text("2분전")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    HStack {
                        Circle()
                            .frame(width: 44)
                        VStack(alignment: .leading) {
                            Text("민콩")
                            Text("이뿌댜앙")
                        }
                        Spacer()
                        Text("2분전")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 5)
                .padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $showingMenu) {
            List {
                Button {
                    showingMenu.toggle() //false
                    showingEdit.toggle() //true
                    
                    
                } label: {
                    Text("글 수정하기")
                }

                Button {
                    postStore.removePost(post)
                } label: {
                    Text("글 삭제하기")
                }
            }
            .presentationDetents([.medium, .large])
        }
        .fullScreenCover(isPresented: $showingEdit) {
            PostEditView(content: post.content, post: $post)
        }
    }
}

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}
