//
//  OOTDPostView.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/20.
//

import SwiftUI

struct OOTDPostView: View {
    @EnvironmentObject var postStore: PostStore
    let post: Post
    //    var index: Int
    
    var body: some View {
        VStack{
            ForEach(postStore.images, id: \.self) { postImage in
                if postImage.id == post.image {
                    
                    Image(uiImage: postImage.image)
                        .resizable()
                        .frame(width: 170, height: 250)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                }
            }
            .overlay(
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 18    ,height: 18)
                    Text(post.nickName)
                        .font(.system(size: 14))
                    Spacer()
                    Text("\(Int(post.temperature))℃")
                }
                    .padding(10)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            )
            
            Text(post.content)
                .frame(width: 160, height: 30)
                .font(.system(size: 12))
                .padding(.bottom, 3)
            HStack{
                HStack{
                    Image(systemName: "heart")
                    Text("123")
                        .offset(x: -5)
                }
                HStack{
                    Image(systemName: "message")
                    Text("123")
                        .offset(x: -5)
                }
                HStack{
                    Image(systemName: "bookmark")
                    Text("123")
                        .offset(x: -5)
                }
            }
            .font(.system(size: 12))
            .padding(.bottom)
        }
//        .onAppear {
//            postStore.fetchPost()
//           
//        }
    }
}

//struct OOTDPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        OOTDPostView()
//    }
//}
