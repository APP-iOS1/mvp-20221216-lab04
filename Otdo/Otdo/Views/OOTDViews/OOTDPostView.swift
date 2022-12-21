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
    var index: Int
    
    var body: some View {
        VStack{
            ZStack{
                if postStore.uiImage != []{
                    Image(uiImage: postStore.uiImage[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:160, height: 250)
                } else {
                    
                }
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 18    ,height: 18)
                    Text(post.nickName)
                        .font(.system(size: 14))
                }
                .offset(x:-40,y: 100)
            }
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
        .onAppear {
            postStore.fetchPost()
        }
    }
}

//struct OOTDPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        OOTDPostView()
//    }
//}
