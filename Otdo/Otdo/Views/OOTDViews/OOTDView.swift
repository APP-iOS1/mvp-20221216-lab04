//
//  OOTDView.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import SwiftUI

struct OOTDView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil)
    ]
    @State private var searchText: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.gray)
                    .padding(15)
                TextField("검색어를 입력해주세요", text: $searchText)
            }
            .background(Color("SearchBar"))
            .cornerRadius(10)
            .padding()
            
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 8,
                    pinnedViews: [],
                    content:  {
                        ForEach(0..<30) { _ in
                            OOTDPostView()
                        }
                    }
                )
            }
        }
    }
}

struct OOTDPostView: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width:160, height: 250)
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 18    ,height: 18)
                    Text("민콩")
                        .font(.system(size: 14))
                }
                .offset(x:-40,y: 100)
            }
            Text("여기는 아무래도 글 내용이 들어가지 않을가용용 뭐라고 적어야 할가용")
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
    }
}

struct OOTDView_Previews: PreviewProvider {
    static var previews: some View {
        OOTDView()
    }
}
