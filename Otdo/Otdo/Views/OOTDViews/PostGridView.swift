//
//  PostGridView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/23.
//

import SwiftUI

struct PostGridView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    
//    let columns: [GridItem] = [
//        GridItem(.flexible(), spacing: 0, alignment: nil),
//        GridItem(.flexible(), spacing: 0, alignment: nil),
//        GridItem(.flexible(), spacing: 0, alignment: nil)
//    ]
    var body: some View {
        GeometryReader { bound in
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: bound.size.width / 3 - 1.2),spacing: 1.2)],
                alignment: .center,
                spacing: 5,
                pinnedViews: [],
                content:  {
                    ForEach(Array(postStore.posts.enumerated()), id: \.offset) { (index, post) in
                        NavigationLink(destination: PostDetailView(post: post, index: index)) {
                            OOTDPostView(post: post)
                        }
                        .foregroundColor(.black).environmentObject(postStore).environmentObject(userInfoStore)
                    }
                }
            )
        }
    }
}

