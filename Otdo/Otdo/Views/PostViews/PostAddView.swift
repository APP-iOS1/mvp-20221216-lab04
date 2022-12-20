//
//  PostAddView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

struct PostAddView: View {
    var body: some View {
        VStack {
            Image("PostDetailImage")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.height * 0.45)
                .border(.gray.opacity(1))
                .padding(20)
            VStack(alignment: .leading) {
                Divider()
                Text("제목")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
                Divider()
                Text("내용")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
                Divider()
                Text("위치추가")
                    .foregroundColor(.gray)
                    .padding(.leading,5)
                Divider()
            }
            .padding()
            
            Button {
                
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

struct PostAddView_Previews: PreviewProvider {
    static var previews: some View {
        PostAddView()
    }
}
