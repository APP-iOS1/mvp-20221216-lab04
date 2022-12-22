//
//  PostDetailView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI
import FirebaseAuth

struct PostDetailView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var commentStore: CommentStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingMenu: Bool = false
    @State private var showingEdit: Bool = false
    @State private var inputComment: String = ""
    @State var post: Post
    
    var index: Int
    var trimComment: String {
        inputComment.trimmingCharacters(in: .whitespaces)
    }
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
                VStack {
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
                    HStack {
                        Image(systemName: "heart.fill")
                            .padding(.leading)
                            .padding(.trailing, -5)
                        Text("1324")
                            .padding(.trailing, -5)
                        Image(systemName: "message")
                            .padding(.trailing, -5)
                        Text("\(commentStore.comments.count)")
                        Spacer()
                        Text("서울시 중랑구")
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            if !postStore.posts.isEmpty {
                                
                                Text("\(postStore.posts[index].nickName)")
                                    .font(.title)
                                    .bold()
                                    .padding(.leading)
                                    .padding(.vertical, -1)
                                Text(postStore.posts[index].content)
                                    .padding(.leading)
                            }
                        }
                        Spacer()
                    }
                    
                    Divider()
                    
                    VStack {
                        ForEach(commentStore.comments) { comment in
                            CommentView(post: $post, index: index, comment: comment)
                                .padding(.vertical, 5)
                            Divider()
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                    
                }
            }
            HStack {
                TextField("댓글을 입력하세요", text: $inputComment)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    let createdAt = Date().timeIntervalSince1970
                    let newComment: Comment = Comment(userId: userInfoStore.currentUser?.uid ?? "", content: inputComment, createdAt: createdAt)
                    commentStore.comments.append(newComment)
                    commentStore.addComment(post, newComment)
                    commentStore.fetchComments(post)
                    inputComment = ""
                    print("\(commentStore.comments)")
                }, label: {
                    Image(systemName: "arrow.up.circle")
                        .font(.title)
                })
                .disabled(trimComment.count > 0 ? false : true)
            }
        }
        
        .sheet(isPresented: $showingMenu, content: {
//            List {
                    Button {
                        showingMenu.toggle() //false
                        showingEdit.toggle() //true
                        
                    } label: {
                        Text("글 수정하기")
                            .foregroundColor(.white)
                    }
//                    .padding(.horizontal, 20)
                    .frame(maxWidth: UIScreen.main.bounds.width - 20, minHeight: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(10)
                    
                    Button {
                        postStore.removePost(post)
                    showingMenu.toggle() //false
                    dismiss()
                    } label: {
                        Text("글 삭제하기")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width - 20, minHeight: 50, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(10)
  //          }
            
            .presentationDetents([.height(150)])
        })
        .fullScreenCover(isPresented: $showingEdit) {
            PostEditView(content: post.content, post: $post)
        }
    }
}


struct CommentView: View {
    @State private var isPresentingConfirm: Bool = false
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var commentStore: CommentStore
    
    @Binding var post: Post
    var index: Int
    var comment: Comment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(postStore.posts[index].nickName)
                        .fontWeight(.black)
                    Spacer()
                    if comment.userId == Auth.auth().currentUser?.uid {
                        Button(action: {
                            isPresentingConfirm = true
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.gray)
                        })
                        .confirmationDialog("댓글을 삭제하시겠습니까?",
                                            isPresented: $isPresentingConfirm) {
                            Button("삭제", role: .destructive) {
                                commentStore.deleteComment(post, comment)
                                commentStore.fetchComments(post)
                            }
                        }
                    }
                }
                Text(comment.content)
                Text(comment.createdDate)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}
