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
    
    var user: User? {
        didSet {
            setProfileImage()
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello world ! \nThis is my insta."
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
//        label.textColor = .lightGray
        return label
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        button.isEnabled = true
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.5)
        button.isEnabled = false
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.5)
        button.isEnabled = false
        return button
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSMutableAttributedString(string: "posts", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSMutableAttributedString(string: "followers", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSMutableAttributedString(string: "following", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    let shareProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(descriptionLabel)
        
        profileImageView.anchor(top: topAnchor, paddingTop: 12, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 12, height: 80, width: 80)
        
        setupBottomToolBar()
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 12, left: leftAnchor, paddingLeft: 12, height: 20, width: nil)
        
        descriptionLabel.anchor(top: usernameLabel.bottomAnchor, paddingTop: 3, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 12, left: leftAnchor, paddingLeft: 12, height: 40, width: nil)
        
        setupUserStatsView()
        
        setupProfileButtons()

    }
    
    fileprivate func setupProfileButtons() {
        let stackView = UIStackView(arrangedSubviews: [editProfileButton, shareProfileButton])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        addSubview(stackView)
        
        stackView.anchor(top: nil, paddingTop: 0, bottom: gridButton.topAnchor, paddingBottom: 8, right: usernameLabel.rightAnchor, paddingRight: 0, left: usernameLabel.leftAnchor, paddingLeft: 0, height: 30, width: nil)
        
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, paddingTop: 12, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 12, left: profileImageView.rightAnchor, paddingLeft: 12, height: 50, width: nil)
    }
    
    fileprivate func setupBottomToolBar() {

        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)

        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, height: 50, width: 0)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, height: 0.2, width: nil)
        
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
