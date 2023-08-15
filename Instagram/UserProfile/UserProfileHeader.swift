//
//  UserProfileHeader.swift
//  Instagram
//
//  Created by Angela Terao on 10/08/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    var user: User? {
        didSet {
            setProfileImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, paddingTop: 12, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 12, height: 80, width: 80)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
    fileprivate func setProfileImage() {
        
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if let err = err {
                print("Failed to fetch profile image:", err)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data)
            }
        }.resume()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
