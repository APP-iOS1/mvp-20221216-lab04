//
//  PostStore.swift
//  Otdo
//
//  Created by 이민경 on 2022/12/20.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PostStore : ObservableObject {
    @Published var posts : [Post] = []
    let database = Firestore.firestore()
    
    init(){
        posts = []
    }
    
    func fetchPost() {
        print("fetch!")
        database.collection("Posts")
            .getDocuments{ (snapshot, error ) in
                self.posts.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let id = document["id"] as? String ?? ""
                        let userId = document["userId"] as? String ?? ""
                        let content = document["content"] as? String ?? ""
                        let nickName = document["nickName"] as? String ?? ""
                        let image = document["image"] as? String ?? ""
                        let likes = document["likes"] as? [String:Bool] ?? [:]
                        let temperature = document["temperature"] as? Double ?? 0.0
                        let createdAt = document["createdAt"] as? Double ?? 0.0
                        
                        self.posts.append(Post(id: id, userId: userId, nickName: nickName, content: content, image: image, likes: likes, temperature: temperature, createdAt: createdAt))
                    }
                    print(self.posts)
                }
            }
    }
    
    func addPost(newPost: Post) {
        Task {
            do {
                let _ = try await database.collection("Posts")
                    .document("\(newPost.id)")
                    .setData(["id": newPost.id,
                              "userId": newPost.userId,
                              "nickName": newPost.nickName,
                              "content": newPost.content,
                              "image": newPost.image,
                              "likes": newPost.likes,
                              "temperature": newPost.temperature,
                              "createdAt": newPost.createdAt,
                              "createdDate": newPost.createdDate
                    ])
            } catch {
                await MainActor.run(body: {
                    print("\(error.localizedDescription)")
                })
            }
        }
    }
    
//    func fetchPost(){
//        print("fetch!")
//        database.collection("").document(userID)
//            .getDocument { snapshot, error in
//                if let snapshot {
//                    print("[snapshot] \(snapshot)")
//                    let id = snapshot["id"] as? String ?? ""
//
//                    let markedPostId = snapshot["markedPostID"] as? [String] ?? []
//                    let email = snapshot["email"] as? String ?? ""
//                    let nickName = snapshot["nickName"] as? String ?? ""
//                    let gender = snapshot["gender"] as? String ?? ""
//                    let age = snapshot["age"] as? Int ?? 0
//                    let profileImage = snapshot["profileImage"] as? String ?? ""
//
//                    self.users.append(UserInfo(id: id, markedPostId: markedPostId, email: email, nickName: nickName, gender: gender, age: age, profileImage: profileImage))
//                    print("\(self.users)")
//                }
//            }
//    }
}

//    func addPost(_ message : String, cheer : Cheer){
////        database.collection("Cheer").document("message").setData([
//        database.collection("Cheer").document("\(message)").setData([
//            "content" : cheer.content,
//            "date" : cheer.createdDate,
//            "nickName" : cheer.nickName,
//            "profile" : "Link",
//
//        ])
//
//        fetchPost()
//    }
