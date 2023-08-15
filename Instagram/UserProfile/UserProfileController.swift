//
//  UserProfileController.swift
//  Instagram
//
//  Created by Angela Terao on 28/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.backgroundColor = .white
        
        fetchUser()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
  
        header.user = self.user
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
    fileprivate func fetchUser(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot, arg  in
            guard let dictionnary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionnary: dictionnary)
          
            self.navigationItem.title = self.user?.username
            self.collectionView.reloadData()
            
        } withCancel: { err in
            print("Failed to fetch user:", err)
        }
    }
    
}

struct User {

    let username: String
    let profileImageUrl: String

    init(dictionnary: [String: Any?]) {
        self.username = dictionnary["username"] as? String ?? ""
        self.profileImageUrl = dictionnary["profileImageURL"] as? String ?? ""
    }

}
