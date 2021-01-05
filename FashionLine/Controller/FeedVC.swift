//
//  FeedVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let feedHeader = "FeedHeader"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate {
    var bottomTitle = Users.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        registrationOfHeaderAndCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogut))
        
        // Do any additional setup after loading the view.
    }
    @objc func handleLogut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
                print("Succesfully loged user out")
            } catch{
                print("Failed signed out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.deleteItems(at: [indexPath])
        registrationOfHeaderAndCell()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.deleteItems(at: [indexPath])
        registrationOfHeaderAndCell()
    }
    override func viewDidAppear(_ animated: Bool) {
        registrationOfHeaderAndCell()
        registrationOfHeaderAndCell()
    }
    fileprivate func registrationOfHeaderAndCell() {
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(CombinesOfDay.self, forCellWithReuseIdentifier: combinesSubCellId)
        self.collectionView!.register(FeedHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: feedHeader)
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.9555
        let height = view.frame.height * 0.35
        return CGSize(width: width, height: height)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        let combinesCell = collectionView.dequeueReusableCell(withReuseIdentifier: combinesSubCellId, for: indexPath) as! CombinesOfDay
        // Configure the cell
        if indexPath.row == 0 {
            cell.titleLabel.text = "Kombin Önerilerim"
            return cell
        }
        else if indexPath.row == 1 {
            combinesCell.titleLabel.text = "Günün Kombinleri"
            return combinesCell
        }
        return cell
    }
    // Header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 155)
        
    }
    // Header on page
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: feedHeader, for: indexPath) as! FeedHeaderCell
        header.delegate = self
        return header
    }
}
extension FeedVC: FeedHeaderCellDelegate {
    func handleProfilePicTapped(for cell: FeedHeaderCell) {
        let profileVC = WardrobeVC()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
