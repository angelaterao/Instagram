//
//  LoginController.swift
//  Instagram
//
//  Created by Angela Terao on 16/08/2023.
//

import UIKit

class LoginController: UIViewController {
    
    let logoContainerView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "instagram_palette"))
        view.contentMode = .scaleAspectFill
        let instaLogo = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        instaLogo.contentMode = .scaleAspectFill
        
        view.addSubview(instaLogo)
        instaLogo.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, height: 50, width: 170)
        instaLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        instaLogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 10).isActive = true
        
        return view
    }()
    
    lazy var emailTextField: LowercaseTextField = {
        let tf = LowercaseTextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: LowercaseTextField = {
        let tf = LowercaseTextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)

//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.lightPeach
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.layer.shadowColor = UIColor.grayShadow.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.0
//        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkPeach]))
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowSignUp() {
        print("Trying to show sing up controller")
        let signUpController = SignUpController()
        
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(logoContainerView)
        view.addSubview(dontHaveAccountButton)
        
        logoContainerView.anchor(top: view.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 200, width: nil)
        
        setupSignInFields()
        
        dontHaveAccountButton.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 15, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 50, width: 0)

    }
    
    fileprivate func setupSignInFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        view.addSubview(stackView)
        view.addSubview(signInButton)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 70, left: view.leftAnchor, paddingLeft: 70, height: 100, width: nil)
        
        signInButton.anchor(top: stackView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, right: view.rightAnchor, paddingRight: 115, left: view.leftAnchor, paddingLeft: 115, height: 43, width: nil)
        
    }
    
}
