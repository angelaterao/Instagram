//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Angela Terao on 28/07/2023.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let userProfileController = UserProfileController(collectionViewLayout: layout)

        let navController = UINavigationController(rootViewController: userProfileController)
        
        navController.tabBarItem.image = UIImage(named: "profile_unselected")
        navController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        
        self.viewControllers = [navController, UIViewController()]
        
    }
}
