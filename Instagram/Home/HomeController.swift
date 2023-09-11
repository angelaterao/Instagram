//
//  HomeController.swift
//  Instagram
//
//  Created by Angela Terao on 09/08/2023.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        fetchPhotos()
    }
    
    fileprivate func setupNavigationItems() {
        
        let titleImage = UIImage(named: "logo2")
        
        navigationItem.titleView = UIImageView(image: titleImage)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell

        cell.posts = posts[indexPath.item]
        
        return cell
    }
    
    fileprivate func fetchPhotos() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            
            guard let dictionnaries = snapshot.value as? [String: Any] else { return }
    
            dictionnaries.forEach { key, value in
                
                guard let dictionnary = value as? [String: Any] else { return }
                
                let post = Post(dictionnary: dictionnary)
                
                self.posts.append(post)
            }

            self.collectionView.reloadData()
            
        }
    }
    
}
