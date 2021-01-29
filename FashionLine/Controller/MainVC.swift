//
//  MainVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 6.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
class MainVC: UITabBarController, UITabBarControllerDelegate {
    
    
    var singletonShared = Users.sharedInstance
    var langFile = Localization.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tabBarController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        langFile.getLangFile()
        self.delegate = self
        if Auth.auth().currentUser?.email == "stylist@fashionline.app"{
            // home feed controller
            guard let darkStarImage = UIImage(named: "darkStar")?.withRenderingMode(.alwaysOriginal) else { return }
            guard let redStarImage = UIImage(named: "redStar")?.withRenderingMode(.alwaysOriginal) else { return }
            
            let feedVC = constructNavController(unselectedImage: darkStarImage, selectedImage:
            redStarImage, rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
            
            viewControllers = [feedVC]
            
        }else{
        configureViewControllers()
        // user validation
        checkIfUserIsLoggedIn()
        self.selectedIndex = 0
        }
    }
    
    func configureViewControllers() {
        if Auth.auth().currentUser?.email?.uppercased() == "stylist@fashionline.app"{
            // home feed controller
            guard let darkStarImage = UIImage(named: "darkStar")?.withRenderingMode(.alwaysOriginal) else { return }
            guard let redStarImage = UIImage(named: "redStar")?.withRenderingMode(.alwaysOriginal) else { return }
            
            let feedVC = constructNavController(unselectedImage: darkStarImage, selectedImage: redStarImage, rootViewController: AdminVC())
            
            viewControllers = [feedVC]
            
        }else{
        
        // home feed controller
        guard let darkStarImage = UIImage(named: "darkStar")?.withRenderingMode(.alwaysOriginal) else { return }
        guard let redStarImage = UIImage(named: "redStar")?.withRenderingMode(.alwaysOriginal) else { return }
        
        let feedVC = constructNavController(unselectedImage: darkStarImage, selectedImage:
            redStarImage, rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        // search feed controller
        guard let darkAddButtonImage = UIImage(named: "TabBarCombine")?.withRenderingMode(.alwaysOriginal) else { return }
        guard let redAddButtonImage = UIImage(named: "TabBarCombineRed")?.withRenderingMode(.alwaysOriginal) else { return }
        let combineVC = constructNavController(unselectedImage: darkAddButtonImage, selectedImage: redAddButtonImage, rootViewController: CombineVC())
        // view controllers to be added to tab controller
        viewControllers = [feedVC, combineVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
        }
    }
    // construct navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // return nav controller
        return navController
    }
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil || !Auth.auth().currentUser!.isEmailVerified {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                
                // UPDATE: iOS 13 presentation fix
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
    
}
