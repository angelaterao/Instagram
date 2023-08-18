//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Angela Terao on 28/07/2023.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {

            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true)
            }
            return
        }
        
        setupViewControllers()
    
        
    }
    
    func setupViewControllers() {
        
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
