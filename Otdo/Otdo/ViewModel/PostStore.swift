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
import FirebaseStorage
import UIKit

/*
 우리가 해야할것
 [넣을때]
 1. 앱의 이미지를 선택해서, 선택한 이미지를 스토리지와 파이어 스토어에 넣는다.!
 - 파이어 스토어에는 이미지 - 이미지 이름을 넣고
 - 스토리지에는 이미지 이름의 사진데이터를 넣는다.
 
 [꺼내올때]
 2. 포스트 이미지를 어싱크 이미지로 해서 이미지를 뿌려준다.
 
 
 
 */

class PostStore : ObservableObject {
    @Published var posts : [Post] = []
    let database = Firestore.firestore()
    
    private var storage = Storage.storage()
    
    
    
    func fetchPostByTemperature(lowTemperature: String, highTemperature: String) {
        let lowTemp: Double = Double(lowTemperature) ?? -20.0
        let highTemp: Double = Double(highTemperature) ?? 50.0
        
        print("fetchByTemperature!")
        
        database.collection("TestPosts")
            .whereField("temperature", isGreaterThanOrEqualTo: lowTemp)
            .whereField("temperature", isLessThanOrEqualTo: highTemp )
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
                        // let postImage = document["postImage"] as? UIImage ?? nil
            
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
                              "image": newPost.image, //이미지이름
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
        
        let imagesRef = storage.reference().child("images/\(post.id)")
        imagesRef.delete { error in
            if let error = error {
                print("Error removing image from storage: \(error.localizedDescription)")
            }
        }
        fetchPost()
    }
    
    func updatePost(_ post: Post) {
        database.collection("TestPosts").document(post.id).updateData([
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
    
    // 사진 업로드
    func uploadImage(image: Data?, name: String) {
        let storageRef = storage.reference().child("images/\(name)") //images/postId/imageName
        let data = image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data{
            storageRef.putData(data, metadata: metadata) {(metadata, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                if let metadata = metadata {
                    print("metadata: \(metadata)")
                }
            }
        }
    }
    
//    // 사진 불러오기
//    func fetchImage(postId: String, imageName: String){
//        let ref = storage.reference().child("images/\(postId)/\(imageName)")
//
//
//
//                // posts배열 중에 postId가 동일한 postImage라는 항목에 Image를 할당해준다.
//
//            }

}


