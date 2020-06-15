//
//  MainVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 6.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit

class MainVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    configureViewControllers()
    }
    
    func configureViewControllers() {
        
        // home feed controller
        guard let darkStarImage = UIImage(named: "darkStar")?.withRenderingMode(.alwaysOriginal) else { return }
        guard let redStarImage = UIImage(named: "redStar")?.withRenderingMode(.alwaysOriginal) else { return }
        
        let feedVC = constructNavController(unselectedImage: darkStarImage, selectedImage:
            redStarImage, rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        // search feed controller
        guard let darkAddButtonImage = UIImage(named: "darkAddButton")?.withRenderingMode(.alwaysOriginal) else { return }
        guard let redAddButtonImage = UIImage(named: "redAddButton")?.withRenderingMode(.alwaysOriginal) else { return }
        let combineVC = constructNavController(unselectedImage: darkAddButtonImage, selectedImage: redAddButtonImage, rootViewController: CombineVC())
        // profile controller
        let wardrobeVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: WardrobeVC())
        
        // view controllers to be added to tab controller
        viewControllers = [feedVC, combineVC, wardrobeVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
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
}
