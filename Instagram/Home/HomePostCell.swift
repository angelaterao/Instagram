//
//  HomePostCell.swift
//  Instagram
//
//  Created by Angela Terao on 11/09/2023.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var posts: Post? {
        didSet {
            guard let photosURL = posts?.imageURL else { return }
            photoImageView.loadImage(urlString: photosURL)
        }
    }
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send2")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSMutableAttributedString(string: " Some caption here that will perhaps wrap onto the next line...", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSMutableAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSMutableAttributedString(string: "1 week ago", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(photoImageView)
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        addSubview(captionLabel)

        userProfileImageView.anchor(top: topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 8, height: 40, width: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2
        
        usernameLabel.anchor(top: topAnchor, paddingTop: 0, bottom: photoImageView.topAnchor, paddingBottom: 0, right: optionsButton.leftAnchor, paddingRight: 0, left: userProfileImageView.rightAnchor, paddingLeft: 8, height: nil, width: nil)
        
        optionsButton.anchor(top: topAnchor, paddingTop: 0, bottom: photoImageView.topAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 8, left: nil, paddingLeft: 0, height: nil, width: 44)
        
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, height: nil, width: nil)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()
        
        captionLabel.anchor(top: likeButton.bottomAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 8, left: leftAnchor, paddingLeft: 8, height: nil, width: nil)
    }
    
    fileprivate func setupActionButtons() {
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(ribbonButton)
        
        stackView.anchor(top: photoImageView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 8, height: 50, width: 120)
        
        ribbonButton.anchor(top: photoImageView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 8, left: nil, paddingLeft: 0, height: 50, width: 40)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
