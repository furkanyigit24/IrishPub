//
//  FeedVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
import OneSignal
private let reuseIdentifier = "Cell"
private let feedHeader = "FeedHeader"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate {
    
    var langFile = Localization.shared
    public var lang: [String: Any] = [:]
    var transferredValue: String?
    var bottomTitle = Users.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        registrationOfHeaderAndCell()
    }
    let fireStoreDatabase = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        let delegate = FeedCell()
        delegate.transferDelegate = self
        
        let status = OneSignal.getDeviceState()
        let playerId = status?.userId
        guard let currentEmail = Auth.auth().currentUser?.email else { return }
        
        notificationArrangements(playerId, currentEmail)
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
    // MARK: - Notifications
    fileprivate func notificationArrangements(_ playerId: String?, _ currentEmail: String) {
        if let playerNewId = playerId {
            
            fireStoreDatabase.collection("PlayerId").whereField("email", isEqualTo: currentEmail).getDocuments { (snapshot, error) in
                if error == nil {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        for document in snapshot!.documents {
                            if let playerIDFromFirebase = document.get("player_id") as? String {
                                let documentId = document.documentID
                                
                                if playerNewId != playerIDFromFirebase {
                                    
                                    let playerIdDictionary = ["email" : currentEmail, "player_id" : playerNewId] as! [String : Any]
                                    
                                    self.fireStoreDatabase.collection("PlayerId").document(currentEmail).setData(playerIdDictionary, merge: true) { (error) in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            
                        }
                    } else {
                        let playerIdDictionary = ["email" : currentEmail, "player_id" : playerNewId] as! [String : Any]
                        
                        self.fireStoreDatabase.collection("PlayerId").document(currentEmail).setData(playerIdDictionary, merge: true) { (error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
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
            cell.titleLabel.text = langFile.format("FeedVC", "suggestions")
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 1 {
            combinesCell.titleLabel.text = langFile.format("FeedVC", "combinesOfDay")
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
extension FeedVC: FeedHeaderCellDelegate, CombinesSuggestionsHeaderTDelegate, TransferDelegate{
    
    func transferValueOfRequest(request: String) {
        transferredValue = request
    }
    
    func handleHeaderCellTapped(for cell: FeedCell) {
        print("header delegated")
        switch transferredValue {
        case "requested":
            let combineDetailVC = CombineDetailVC()
            navigationController?.pushViewController(combineDetailVC, animated: true)
        default:
            print("Default")
        }
    }
    
    func handleProfilePicTapped(for cell: FeedHeaderCell) {
        let profileVC = WardrobeVC()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
