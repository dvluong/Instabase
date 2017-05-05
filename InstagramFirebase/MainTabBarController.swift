//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by David Luong on 4/6/17.
//  Copyright © 2017 Stanford Graduate School of Education. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        if FIRAuth.auth()?.currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            present(navController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    func setupViewControllers() {
        
        //home
        let homeNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))

        //search
        let searchNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let plusNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let likeNavController = templateNavController(selectedImage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController: UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileViewController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, userProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else {
            return
        }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func templateNavController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.image = unselectedImage
        viewController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
