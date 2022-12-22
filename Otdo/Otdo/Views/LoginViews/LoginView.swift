//
//  LoginView.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/19.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var userInfoStore: UserInfoStore
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var secureField: Bool = true
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                VStack {
                    Text("OTDO")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .italic()
                    Text("온도별 옷차림")
                        .fontWeight(.light)
                }
                Spacer()
                TextField(" 이메일을 입력해주세요", text: $email)
                    .modifier(TextFieldModifier())
                    .padding(.vertical, 5)
                    .autocapitalization(.none)
                
                HStack{
                    if secureField {
                        SecureField(" 비밀번호를 입력해주세요", text: $password)
                            .frame(height: 50)
                    } else {
                        TextField(" 비밀번호를 입력해주세요", text: $password)
                            .frame(height: 50)
                    }
                    Button(action: {
                        secureField.toggle()
                    }) {
                        Image(systemName: secureField ? "eye" : "eye.slash")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .modifier(TextFieldModifier())
                
                HStack{
                    // 틀렸을시 글씨색 빨간색으로
                    Text("이메일 또는 비밀번호를 다시 확인하세요.")
                        .font(.footnote)
                        .padding(.trailing, 10)
                        .foregroundColor(.white)
                    NavigationLink(destination: Text("비밀번호 찾기")) {
                        Text("비밀번호를 잊으셨나요?")
                            .font(.footnote)
                        
                    }
                }
                Spacer()
                
                VStack{
                    Button(action: {
                            userInfoStore.loginUser(emailID: email, password: password)
                            
                        if userInfoStore.currentUser != nil {
                            viewRouter.currentPage = .mainView
                        }
                    }){
                        Text("로그인")
                            .foregroundColor(.white)
                            .bold()
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .frame(width: 360, height: 50)
                                    .foregroundColor(.black)
                            }
                    }
                    .padding(.vertical)
                    
                    Button(action: {
                        
                    }){
                        Text("구글 로그인")
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 328, height: 48)
                            .padding(.horizontal, 15)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(.gray, lineWidth: 2)
                            }
                    }
                   
                }
                Spacer()
                HStack{
                    Text("계정이 없으신가요?")
                        .font(.footnote)
                    NavigationLink(destination: RegisterView()) {
                        Text("회원가입")
                            .font(.footnote)
                    }
                }
            }
            .padding()
        }
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(height: 50)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.gray, lineWidth: 2)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
