//
//  SharePhotoController.swift
//  Instagram
//
//  Created by Angela Terao on 31/08/2023.
//

import UIKit

class SharePhotoController: UIViewController, UITextViewDelegate {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    let descriptionTextView: UITextView = {
        let tf = UITextView()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.text = "Write a caption..."
        tf.textColor = UIColor.lightGray
        return tf
    }()
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write a caption..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationButtons()
        view.backgroundColor = .grayScreen
        
        setupImageAndTextViews()
        descriptionTextView.delegate = self
    }
    
    fileprivate func setupNavigationButtons() {
        
        navigationItem.title = "New Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        navigationController?.navigationBar.tintColor = .black
    }
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(descriptionTextView)
        
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 100, width: nil)
        
        imageView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: containerView.leftAnchor, paddingLeft: 10, height: 80, width: 80)
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        descriptionTextView.anchor(top: containerView.topAnchor, paddingTop: 0, bottom: containerView.bottomAnchor, paddingBottom: 0, right: containerView.rightAnchor, paddingRight: 10, left: imageView.rightAnchor, paddingLeft: 10, height: nil, width: nil)
        
        
        
    }
    
    @objc func handleShare() {
        print("Sharing photo")
    }

}
