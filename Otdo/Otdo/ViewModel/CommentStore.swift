//
//  CommentStore.swift
//  Otdo
//
//  Created by 박성민 on 2022/12/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    
    private let database = Firestore.firestore()
    
    func fetchComments(_ post: Post) {
        database.collection("Posts").document("\(post.id)").collection("Comments")
            .order(by: "createdAt", descending: true)
            .getDocuments{ (snapshot, error ) in
                self.comments.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let id = document["id"] as? String ?? ""
                        let userId = document["userId"] as? String ?? ""
                        let content = document["content"] as? String ?? ""
                        let createdAt = document["createdAt"] as? Double ?? 0.0
                        
                        let comment: Comment = Comment(id: id, userId: userId, content: content, createdAt: createdAt)
                        self.comments.append(comment)
                        
                    }
                }
            }
    }
    
    func addComment(_ post: Post, _ comment: Comment) {
        
        database.collection("Posts").document("\(post.id)").collection("Comments").document("\(comment.id)")
            .setData([
                "id": comment.id,
                "userId": Auth.auth().currentUser?.uid ?? "",
                "content": comment.content,
                "createdAt": comment.createdAt,
            ])
    }
    
    func deleteComment (_ post: Post,_ comment: Comment) {
        database.collection("Posts").document("\(post.id)").collection("Comments").document(comment.id).delete()
        comments.removeLast()
    }
}
