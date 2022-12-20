//
//  PostAddView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

struct PostAddView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @Binding var isShowingAdd: Bool
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var location: String = ""
    
    var body: some View {
        VStack {
            Image("PostDetailImage")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height * 0.45)
                .border(.gray.opacity(1))
                .padding(20)
            VStack(alignment: .leading) {
                Divider()
                TextField("내용을 입력해주세요", text: $content)
                    .frame(height: 100)
                    .padding(.leading,5)
                Divider()
                Text("위치추가")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
                Divider()
            }
            .padding()
            
            Button {
                let createdAt = Date().timeIntervalSince1970
                postStore.addPost(newPost: Post(id: UUID().uuidString, userId: userInfoStore.currentUser?.uid ?? "", content: content, image: "", likes: [:], temperature: 2.0, createdAt: createdAt))
            } label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.07)
                    Text("게시물 추가")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

//struct PostAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostAddView()
//    }
//}
