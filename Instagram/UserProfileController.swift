//
//  UserProfileController.swift
//  Instagram
//
//  Created by Angela Terao on 28/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.backgroundColor = .white
        
        fetchUser()
        
    }
    
    fileprivate func fetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            let dictionnary = snapshot.value as? [String: Any]
            let username = dictionnary?["username"] as? String
                
            self.navigationItem.title = username
        } withCancel: { err in
            print("Failed to fetch user:", err)
        }

    }
    
}
