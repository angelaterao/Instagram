//
//  UserProfilePhotoCell.swift
//  Instagram
//
//  Created by Angela Terao on 07/09/2023.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            print("Post: \(post?.imageURL ?? "")")
            
            guard let imageURL = post?.imageURL else { return }
            guard let url = URL(string: imageURL) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, err in
                if let err = err {
                    print("Failed fetching post photo:", err)
                    return
                }
                guard let imageData = data else { return }
                
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
 
            }.resume()
            
        }
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, height: nil, width: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
