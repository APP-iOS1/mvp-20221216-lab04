//
//  RecommendView.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/23.
//

import SwiftUI

struct RecommendView: View {
    @EnvironmentObject var postStore: PostStore
    
    let post: Post
    
    var body: some View {
        
        HStack {
            ForEach(postStore.images, id: \.self) { postImage in
                if postImage.id == post.image {
                    
                    Image(uiImage: postImage.image)
                        .resizable()
                        .frame(width: 250, height: 350)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                }
            }
        }
        
    }
}

//struct RecommendView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendView(post)
//    }
//}
