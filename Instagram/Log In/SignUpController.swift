//
//  ViewController.swift
//  Instagram
//
//  Created by Angela Terao on 25/07/2023.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "addphoto")
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage") ] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.darkPeach.cgColor
        plusPhotoButton.layer.borderWidth = 2

        dismiss(animated: true)
    }
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged) 
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.lightPeach
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.layer.shadowColor = UIColor.grayShadow.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.0
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkPeach]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handleTextInputChange() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 &&  passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.darkPeach
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.lightPeach
        }
    }
    
    @objc private func handleSignUp() {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, err in
            if let err = err {
                print("Failed to create user: ", err)
                return
            }
            
            print("Success creating user: ", user?.user.uid ?? "")

            
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let fileName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child(fileName)
            
            // Saving image to Storage
            
            storageRef.putData(uploadData) { metadata, err in
                if let err = err {
                    print("Failed at saving image to storage: ", err)
                    return
                }
                
                // Getting the image's URL
                
                storageRef.downloadURL { url, err in
                    if let err = err {
                        print("Failed at getting URL's image: ", err)
                        return
                    }
                    
                    guard let urlString = url?.absoluteString else { return }
                    print("Success :", urlString)
                    
                    // Saving user and profile image's URL to database
                    
                    guard let uid = user?.user.uid else { return }

                    let dictionaryValues = ["username": username, "profileImageURL": urlString]
                    let values = [uid:dictionaryValues]

                    Database.database().reference().child("users").updateChildValues(values) { err, ref in
                        if let err = err {
                            print("Failed to save user info into database: ", err)
                            return
                        }

                        print("Sucessfully saved user info into database")
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(plusPhotoButton)
        view.addSubview(alreadyHaveAccountButton)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        plusPhotoButton.anchor(top: view.topAnchor, paddingTop: 150, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 100, width: 100)
        
        
        setupSignUpFields()
        
        alreadyHaveAccountButton.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 10, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 50, width: 0)
        
    }
    
    fileprivate func setupSignUpFields() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField])

        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 12
        
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 70, left: view.leftAnchor, paddingLeft: 70, height: 150, width: nil)
        
        signUpButton.anchor(top: stackView.bottomAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 115, left: view.leftAnchor, paddingLeft: 115, height: 43, width: nil)

    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, right: NSLayoutXAxisAnchor?,  paddingRight: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, height: CGFloat?, width: CGFloat?) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}


