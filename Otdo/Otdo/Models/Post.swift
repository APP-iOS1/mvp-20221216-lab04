//
//  Post.swift
//  Otdo
//
//  Created by BOMBSGIE on 2022/12/19.
//

import Foundation
import SwiftUI
struct Post: Identifiable {
    var id: String
    var userId: String
    var nickName: String
    
    var content: String
    var image: String
    var likes: [String: Bool]
    var temperature: Double
//  var bookmark: Bool
    
    var createdAt: Double
    var postImage: UIImage?
    var createdDate: String {
        let dateFormatter = DateFormatter()
    
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // "yyyy-MM-dd HH:mm:ss"
        
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
}


