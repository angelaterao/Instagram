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
        
        let userProfilelayout = UICollectionViewFlowLayout()
        userProfilelayout.scrollDirection = .vertical
        let userProfileController = UserProfileController(collectionViewLayout: userProfilelayout)

        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = UIImage(named: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.scrollDirection = .vertical
        let homeController = HomeController(collectionViewLayout: homeLayout)
        let homeNavController = UINavigationController(rootViewController: homeController)
        
        homeNavController.tabBarItem.image = UIImage(named: "home unselected")
        homeNavController.tabBarItem.selectedImage = UIImage(named: "home selected")
        
        tabBar.tintColor = .black
        
        self.viewControllers = [userProfileNavController, homeNavController]
        
    }
}
