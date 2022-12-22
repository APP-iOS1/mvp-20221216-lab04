//
//  OOTDView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI

struct OOTDView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil)
    ]
    @State private var searchText: String = ""
    @State var isShowingAdd: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                        .padding(15)
                    TextField("사용자 검색", text: $searchText)
                }
                .background(Color("SearchBar"))
                .cornerRadius(10)
                .padding(.horizontal, 10)
                
                TemperatureSliderView()
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 8,
                        pinnedViews: [],
                        content:  {
                            ForEach(Array(postStore.posts.enumerated()), id: \.offset) { (index, post) in
                                NavigationLink(destination: PostDetailView(post: post, index: index)) {
                                    OOTDPostView(post: post)
                                }
                                .foregroundColor(.black)
                            }
                        }
                    )
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
            }
            .toolbar{
                ToolbarItem {
                    Button {
                        isShowingAdd.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }// NavigationStack
        .sheet(isPresented: $isShowingAdd) {
            PostAddView(isShowingAdd: $isShowingAdd).environmentObject(postStore).environmentObject(userInfoStore)
        }
        .refreshable {
            postStore.fetchPost()
            for post in postStore.posts {
                postStore.retrievePhotos(post)
            }
        }
        .onAppear {
            postStore.fetchPost()
        }
    }
}
    
    
//    struct OOTDView_Previews: PreviewProvider {
//        static var previews: some View {
//            OOTDView()
//        }
//    }
