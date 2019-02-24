//
//  Comment.swift
//  A.T.W.N
//
//  Created by lioz balki on 08/02/2019.
//  Copyright © 2019 lioz balki. All rights reserved.
//

import UIKit

struct Comment: Hashable {
    
    var hasValue: Int {
        return id.hashValue
    }
    
    static func == (lhs: Comment, rhs: Comment) -> Bool {
       return lhs.id == rhs.id
    }
    
    var id: String?
    var text: String?
    var postId: String?
    var senderName: String?
    var senderImage: String?
    var timeInterval: Double?
    
}

extension Comment {
    static func setComment(with dictionary: dictionary) -> Comment {
        var comment = Comment()
        
        comment.id = dictionary["id"] as? String
        comment.text = dictionary["text"] as? String
        comment.postId = dictionary["postId"] as? String
        comment.senderName = dictionary["senderName"] as? String
        comment.senderImage = dictionary["senderImage"] as? String
        comment.timeInterval = dictionary["timeInterval"] as? Double
        
        return comment
    }
}
