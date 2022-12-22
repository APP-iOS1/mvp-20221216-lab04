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
    
    func fetchPostByTemperature(lowTemperature: Double, highTemperature: Double) {
        print("fetchByTemperature!")
        
        database.collection("Posts")
            .whereField("temperature", isGreaterThanOrEqualTo: lowTemperature)
            .whereField("temperature", isLessThanOrEqualTo: highTemperature )
//            .order(by: "createdDate", descending: true)
        // FIXME: - 파베에서 복합쿼리를 사용할 때 복합색인을 추가해주어야 함
        // 지금은 이해 못 해서 날짜 정렬 잠시 포기하고 temperature 필드값만 확인해줌T^T
        // 한 건지 안 한 건지 모르겠다,,?
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
    
    
    func fetchPost() {
        print("fetch!")
        database.collection("TestPosts")
            .order(by: "createdDate", descending: true)
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
                let _ = try await database.collection("TestPosts")
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
        fetchPost()
    }
    
    func removePost(_ post:Post) {
        database.collection("Posts").document(post.id).delete()
        { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
        fetchPost()
    }
    
    func updatePost(_ post: Post) {
        database.collection("Posts").document(post.id).updateData([
            "id": post.id,
            "userId": post.userId,
            "content": post.content,
            "nickName": post.nickName,
            "image": post.image,
            "likes": post.likes,
            "temperature": post.temperature,
            "createdAt": post.createdAt,
            "createdDate": post.createdDate
        ], completion: { error in
            if let error {
                print(error)
            }
        })
        fetchPost()
    }
    
}


