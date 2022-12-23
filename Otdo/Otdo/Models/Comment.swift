//
//  Comment.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import Foundation

struct Comment: Identifiable, Hashable {
    var id: String
//    var postId: String
    var userId: String
    var postId: String
    var nickName: String
    var content: String
    var createdAt: Double
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
    
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
}
