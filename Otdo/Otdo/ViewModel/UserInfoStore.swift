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
import GoogleSignIn

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
                
                print("[현재 로그인] \(String(describing: self.currentUser))")
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
    
    
    func googleSignIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                googleAuthenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                googleAuthenticateUser(for: user, with: error)
            }
        }
    }
    
    private func googleAuthenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
            } else {
                self.currentUser = result?.user
                Task {
                    do {
                        guard let userUID = Auth.auth().currentUser?.uid else { return }

                        let _ = try await database.collection("Users")
                            .document(userUID)
                            .setData([
                                "id": userUID,
                                "markedPostID": [],
                                "email": result?.user.email,
                                "nickName": result?.user.displayName,
                                "gender": "",
                                "age": "",
                                "profileImage": ""
                            ])
                    } catch {
                        await MainActor.run(body: {
                            print("\(error.localizedDescription)")
                        })
                    }
                }

                print("[현재 로그인] \(String(describing: self.currentUser))")
            }
        }
    }
    
    func googleSignOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
            try Auth.auth().signOut()
            
            print("로그아웃 성공")
        } catch {
            print(error.localizedDescription)
        }
    }
}
