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
        getDataFromFirestore()
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
    // MARK: -- Firestore Data
    func getDataFromFirestore(){
        
        let db = Firestore.firestore()
        db.collection("Kullanıcılar").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let userInfo = document.get("KişiselBilgiler") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Ad" {
                                    guard let name = value as? String else { return }
                                    self.singletonShared.nameArray.append(name)
                                }
                                else if key == "Boy" {
                                    guard let height = value as? String else { return }
                                    self.singletonShared.heightArray.append(height)
                                }
                                else if key == "Cinsiyet" {
                                    guard let gender = value as? String else { return }
                                    self.singletonShared.genderArray.append(gender)
                                }
                                else if key == "Eposta" {
                                    guard let eMail = value as? String else { return }
                                    self.singletonShared.ePostaArray.append(eMail)
                                }
                                else if key == "Kilo" {
                                    guard let weight = value as? String else { return }
                                    self.singletonShared.weightArray.append(weight)
                                }
                                else if key == "Tarz" {
                                    guard let style = value as? String else { return }
                                    self.singletonShared.styleArray.append(style)
                                }
                                else if key == "Yaş" {
                                    guard let age = value as? String else { return }
                                    self.singletonShared.ageArray.append(age)
                                }
                                else if key == "Şifre" {
                                    guard let password = value as? String else { return }
                                    self.singletonShared.passwordArray.append(password)
                                }
                                else {
                                    print("Kişisel Bilgiler sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                        
                        if let userInfoCombine = document.get("Kombin") as? [String: Any]{
                            for (key,value) in userInfoCombine {
                                if key == "Adı" {
                                    guard let nameCombine = value as? String else { return }
                                    self.singletonShared.nameCombineArray.append(nameCombine)
                                }
                                else if key == "Linki" {
                                    guard let link = value as? String else { return }
                                    self.singletonShared.linkArray.append(link)
                                }
                                else if key == "Saati" {
                                    guard let time = value as? String else { return }
                                    self.singletonShared.timeArray.append(time)
                                }
                                else if key == "StilistYorumu" {
                                    guard let stylerComment = value as? String else { return }
                                    self.singletonShared.stylerCommentArray.append(stylerComment)
                                }
                                else {
                                    print("Kombin sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                    }
                    self.tabBarController?.reloadInputViews()
                }
            }
        }
    }
}
