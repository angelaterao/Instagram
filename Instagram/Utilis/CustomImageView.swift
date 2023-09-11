//
//  CustomImageView.swift
//  Instagram
//
//  Created by Angela Terao on 08/09/2023.
//

import UIKit

var imageCached = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = imageCached[urlString] {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if let err = err {
                print("Failed fetching post photo:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCached[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }

        }.resume()
        
        
    }
    
    
}
