//
//  SharePhotoController.swift
//  Instagram
//
//  Created by Angela Terao on 31/08/2023.
//

import UIKit
import Firebase
import FirebaseStorage

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

        guard let image = self.imageView.image else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(fileName)
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // Saving image to Storage
        
        storageRef.putData(uploadData) { metadata, err in
            if let err = err {
                print("Failed at saving image to storage: ", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            // Getting the image's URL
            
            storageRef.downloadURL { url, err in
                if let err = err {
                    print("Failed at getting URL's image: ", err)
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    return
                }
                
                guard let imageURL = url?.absoluteString else { return }
                print("Success :", imageURL)
                
                self.saveToDatabaseWithImageURL(imageURL: imageURL)
                
            }
        }
    }
    
    fileprivate func saveToDatabaseWithImageURL(imageURL: String) {
        
        guard let postImage = imageView.image else { return }
        
        guard var caption = descriptionTextView.text else { return }
        if caption == "Write a caption..." {
            caption = ""
        }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        
        //childByAutoId generates a new child location using a unique key, useful when the DB is a list
        let ref = userPostRef.childByAutoId()
        
        let values = ["imageURL": imageURL, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { err, ref in
            if let err = err {
                print("Failed to save to DB", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            print("Sucessfully added")
            self.dismiss(animated: true)
        }
        
    }

}
