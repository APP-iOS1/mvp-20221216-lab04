//
//  OOTDPostView.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/20.
//

import SwiftUI

struct OOTDPostView: View {
    let post: Post
    
    var body: some View {
        VStack{
<<<<<<< Updated upstream
                RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .frame(width:160, height: 250)
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
=======
            
            AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/otdo-7cd2d.appspot.com/o/images%2F\(post.id)%2F\(post.image)?alt=media")) { image in
                image
                    .resizable()
                    .frame(width: 170, height: 250)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(15)
            }placeholder: {
                ProgressView()
            }
            .overlay(
                HStack{
                    Image("NullProfile")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .shadow(radius: 1)
                    Text(post.nickName)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                    Spacer()
                    Text("\(Int(post.temperature))℃")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
//                        .background(content: {
//                            Rectangle()
//                                .fill(.white.opacity(0.5))
//                                .cornerRadius(7)
//                        })
                }
                    .padding(10)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            )
>>>>>>> Stashed changes
            
            Text(post.content)
                .frame(width: 160, height: 30, alignment: .leading)
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
    }
}

//struct OOTDPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        OOTDPostView()
//    }
//}
