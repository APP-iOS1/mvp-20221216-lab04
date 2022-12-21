//
//  UserInfoStore.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/19.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserInfoStore: ObservableObject {
    @Published var users: [UserInfo] = []
    @Published var currentUser: Firebase.User?
    

    let database = Firestore.firestore()
    
    
    init() {
        currentUser = Auth.auth().currentUser
    }

    func registerUser(newUser: UserInfo, password: String) {
        Task {
            do {
                try await Auth.auth().createUser(withEmail: newUser.email, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else { return }

                let _ = try await database.collection("Users")
                    .document(userUID)
                    .setData([
                        "id": userUID,
                        "markedPostID": [],
                        "email": newUser.email,
                        "nickName": newUser.nickName,
                        "gender": newUser.gender,
                        "age": newUser.age,
                        "profileImage": ""
                    ])
            } catch {
                await MainActor.run(body: {
                    print("\(error.localizedDescription)")
                })
            }
        }
    }
    
    func loginUser(emailID: String, password: String) {
        Task {
            // With the help of Swift Concurrency Auth can be done with Single Line
            
            Auth.auth().signIn(withEmail: emailID, password: password) { result, error in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    return
                }
                print("User Found")
                self.currentUser = result?.user
                
                print("[현재 로그인] \(self.currentUser)")
            }
            fetchUser()
        }
    }
    
    // 로그아웃 해주는 함수
    func logout() {
        currentUser = nil
        do {
            try Auth.auth().signOut()
           
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func fetchUser(){
        self.users.removeAll()
        print("fetch!")
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print("\(userID)")
        database.collection("Users")
            .document(userID)
            .getDocument { snapshot, error in
                if let snapshot {
                    print("[snapshot] \(snapshot)")
                    let id = snapshot["id"] as? String ?? ""
                    let markedPostId = snapshot["markedPostID"] as? [String] ?? []
                    let email = snapshot["email"] as? String ?? ""
                    let nickName = snapshot["nickName"] as? String ?? ""
                    let gender = snapshot["gender"] as? String ?? ""
                    let age = snapshot["age"] as? Int ?? 0
                    let profileImage = snapshot["profileImage"] as? String ?? ""

                    self.users.append(UserInfo(id: id, markedPostId: markedPostId, email: email, nickName: nickName, gender: gender, age: age, profileImage: profileImage))
                    print("\(self.users)")
                }
            }
    }
}
