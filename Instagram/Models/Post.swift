//
//  Post.swift
//  Instagram
//
//  Created by Angela Terao on 07/09/2023.
//

import UIKit

struct Post {
    
    let imageURL: String
    
    init(dictionnary: [String: Any]) {
        self.imageURL = dictionnary["imageURL"] as? String ?? ""
    }
    
}
