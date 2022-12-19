//
//  UserInfoStore.swift
//  Otdo
//
//  Created by do hee kim on 2022/12/19.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserInfoStore: ObservableObject {
    @Published var users: [UserInfo]

    let database = Firestore.firestore()
    
    init(users: [UserInfo] = []) {
        self.users = users
    }

    func registerUser(newUser: UserInfo, password: String) {
        Task {
            do {
                try await Auth.auth().createUser(withEmail: newUser.email, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else { return }

                let _ = try await database.collection("Users")
                    .document(userUID)
                    .setData([
                        "id": newUser.id,
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
            do {
                // With the help of Swift Concurrency Auth can be done with Single Line
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                fetchUser()
            } catch {
                print("\(error)")
            }
        }
    }
    
//    func fetchUser() async throws {
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument()
//
//        await MainActor.run(body: {
//            // Setting UserDefaults data and Changing App's Auth Status
//            print("\(user)")
//        })
//    }
    
    func fetchUser(){
        print("fetch!")
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print("\(userID)")
        database.collection("Users")
            .document(userID)
            .getDocument { snapshot, error in
                if let snapshot {
                    print("[snapshot] \(snapshot)")
                    let id = snapshot["id"] as? String ?? ""
//                    print(id)
                    let markedPostId = snapshot["markedPostID"] as? [String] ?? []
//                    print(markedPostId)
                    let email = snapshot["email"] as? String ?? ""
//                    print(email)
                    let nickName = snapshot["nickName"] as? String ?? ""
//                    print(nickName)
                    let gender = snapshot["gender"] as? String ?? ""
//                    print(gender)
                    let age = snapshot["age"] as? Int ?? 0
//                    print(age)
                    let profileImage = snapshot["profileImage"] as? String ?? ""
//                    print(profileImage)
                    
                    self.users.append(UserInfo(id: id, markedPostId: markedPostId, email: email, nickName: nickName, gender: gender, age: age, profileImage: profileImage))
                    print("\(self.users)")
                }
            }
    }
}
