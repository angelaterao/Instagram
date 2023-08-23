//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Angela Terao on 28/07/2023.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
      
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
            
            
            return false
        }
        
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
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
        
        let userProfileNavController = templateNavController(rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()), nameImageUnselected: "profile_unselected", nameImageSelected: "profile_selected")

        let homeNavController = templateNavController(rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()), nameImageUnselected: "home unselected", nameImageSelected: "home selected")
        
        let searchNavController = templateNavController(nameImageUnselected: "search_unselected", nameImageSelected: "search_selected")
        
        let plusNavController = templateNavController(nameImageUnselected: "plus_unselected", nameImageSelected: "plus_unselected")
        
        let likeNavController = templateNavController(nameImageUnselected: "like_unselected", nameImageSelected: "like_selected")

        tabBar.tintColor = .black
        
        self.viewControllers = [userProfileNavController,
                                searchNavController,
                                plusNavController,
                                likeNavController,
                                homeNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        
    }
    
    
    
    fileprivate func templateNavController(rootViewController: UIViewController = UIViewController(), nameImageUnselected: String, nameImageSelected: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = UIImage(named: nameImageUnselected)
        navController.tabBarItem.selectedImage = UIImage(named: nameImageSelected)

        return navController
    }
}
