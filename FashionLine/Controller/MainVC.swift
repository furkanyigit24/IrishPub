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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tabBarController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureViewControllers()
        self.selectedIndex = 1
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
        // view controllers to be added to tab controller
        viewControllers = [feedVC, combineVC]
        
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
