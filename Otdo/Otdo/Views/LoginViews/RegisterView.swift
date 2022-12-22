//
//  RegisterView.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/19.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @State var emailID: String = ""
    @State var password: String = ""
    @State var nickName: String = ""

    @State private var isMale: Bool = true
    @State private var isFemale: Bool = false
    @State private var selectedGender: Gender = .male
    
    @State private var selectedAge = 14
    let ageArr = Array(14...65)
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 12) {
            Text("OtDo")
                .font(.largeTitle)
                .bold()
            
            TextField("otdo@gmail.com", text: $emailID)
                .textContentType(.emailAddress)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                }
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                }
            
            TextField("Nickname", text: $nickName)
                .textContentType(.emailAddress)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                }
            
            HStack {
                Text("성별")
                HStack {
                    Button {
                        isMale = true
                        isFemale = false
                        selectedGender = .male
                    } label: {
                        HStack {
                            Image(systemName: isMale ? "largecircle.fill.circle" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("남자")
                        }
                    }
                    Button {
                        isMale = false
                        isFemale = true
                        selectedGender = .female
                    } label: {
                        HStack {
                            Image(systemName: isFemale ? "largecircle.fill.circle" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("여자")
                        }
                    }
                }
                .padding(.leading, 10)
                .foregroundColor(.black)

                Spacer()
            }
            
            HStack {
                Text("나이")
                Picker(selection: $selectedAge, label: Text("")) {
                    ForEach(ageArr, id: \.self) { age in
                        Text("\(age)")
                    }
                }
                .pickerStyle(.automatic)
                Spacer()
            }
            
            Button {
                let user = UserInfo(id: UUID().uuidString, markedPostId: [], email: emailID, nickName: nickName, gender: String("\(selectedGender)"), age: selectedAge, profileImage: "")
                userInfoStore.registerUser(newUser: user, password: password)
                dismiss()
            } label: {
                // MARK : Sign Up Button
                Text("Sign up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.black)
                    }
                    .disabled(nickName == "" || emailID == "" || password == "" || password.count < 6)
                    .opacity(nickName == "" || emailID == "" || password == "" || password.count < 6 ? 0.6 : 1)
                    .padding(.top, 10)
                
            }
        }
        .padding(15)
        
        HStack {
            Text("이미 계정이 있으신가요?")
                .foregroundColor(.gray)
            
            Button("로그인 하러 가기") {
                dismiss()
            }
            .fontWeight(.bold)
            .foregroundColor(.black)
        }
        .font(.callout)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

enum Gender: String {
    case male = "남자"
    case female = "여자"
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
