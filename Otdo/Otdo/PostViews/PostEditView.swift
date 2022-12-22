//
//  PostEditView.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/20.
//

import SwiftUI
import PhotosUI
struct PostEditView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @Environment(\.dismiss) var dismiss

    @State var content: String
    @State private var location: String = ""
    @State private var editSelectedImage: PhotosPickerItem? = nil
    @State private var editselectedImageData: Data? = nil

    
    var post: Post
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $editSelectedImage,
                matching: .images,
                photoLibrary: .shared()) {
                    if editselectedImageData == nil {
                        ForEach(postStore.images, id: \.self) { postImage in
                            if postImage.id == post.image {
                                
                                Image(uiImage: postImage.image)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height * 0.45)
                                    .border(.gray.opacity(1))
                                    .padding(20)
                                    .padding(.top,10)
                            }
                        }
                    } else {
                        if let editselectedImageData,
                           let uiImage = UIImage(data: editselectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height * 0.45)
                                .border(.gray.opacity(1))
                                .padding(20)
                        }
                    }
                }
                .onChange(of: editSelectedImage) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            editselectedImageData = data
//                            postStore.removeImage(post)
                        }
                    }
                }
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
                print(userInfoStore.users.count)
                for user in userInfoStore.users {
                    if user.id == userInfoStore.currentUser?.uid {
                        let post = Post(id: post.id, userId: post.userId, nickName: post.nickName, content: content, image: post.image, likes: post.likes, temperature: post.temperature, createdAt: post.createdAt)
                        if editselectedImageData == nil {
                            postStore.removeImage(post)
                            postStore.uploadImage(image: editselectedImageData, postImage: post.image)
                        }
                        postStore.updatePost(post)

                    }
                }
                dismiss()
            } label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.07)
                    Text("게시물 수정")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            userInfoStore.fetchUser()
        }
    }
}

//struct PostEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostEditView()
//    }
//}
