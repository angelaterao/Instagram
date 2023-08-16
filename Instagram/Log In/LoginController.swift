//
//  LoginController.swift
//  Instagram
//
//  Created by Angela Terao on 16/08/2023.
//

import UIKit

class LoginController: UIViewController {
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowSignUp() {
        print("Trying to show sing up controller")
        let signUpController = SignUpController()
        
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(signUpButton)
        
        signUpButton.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, height: 50, width: 0)

 
    }
    
}
