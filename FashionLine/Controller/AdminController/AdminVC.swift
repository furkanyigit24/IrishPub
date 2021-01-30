//
//  AdminVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
import OneSignal
let adminTableViewCell = "AdminTableViewCell"

class AdminVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shared = Admin.sharedInstance
    let fireStoreDatabase = Firestore.firestore()
    var userNameArray = [String]()
    var heightArray = [String]()
    var weightArray = [String]()
    var sexArray = [String]()
    var emailArray = [String]()
    var styleArray = [String]()
    var ageArray = [String]()
    var nameCombineArray = [String]()
    var linkArray = [String]()
    var timeArray = [String]()
    var stylerCommentArray = [String]()
    
    let headerView: HeaderView = {
        let view = HeaderView()
        return view
    }()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(headerView)
//        headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 375, height: 127)

        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.register(AdminCell.self, forCellReuseIdentifier: adminTableViewCell)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        navigationController?.navigationBar.isHidden = false
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#E61515", alpha: 0.82)]
        navigationItem.title = "FashionLine"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(HandleLogOut))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.tableFooterView = UIView()
        // Call Firebase
        getDataFromFirestore()
       // requestedListener()
        let status = OneSignal.getDeviceState()
        let playerId = status?.userId
        guard let currentEmail = Auth.auth().currentUser?.email else { return }
        
        notificationArrangements(playerId, currentEmail)
    }
    // MARK: - Notifications
    fileprivate func notificationArrangements(_ playerId: String?, _ currentEmail: String) {
        if let playerNewId = playerId {
    
            fireStoreDatabase.collection("PlayerIdOfStylist").whereField("email", isEqualTo: currentEmail).getDocuments { (snapshot, error) in
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
                        
                        self.fireStoreDatabase.collection("PlayerIdOfStylist").document(currentEmail).setData(playerIdDictionary, merge: true) { (error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: -- Firestore Data
    func getDataFromFirestore(){
        
        let db = Firestore.firestore()
        db.collection("Kullanıcılar").whereField("Request", isEqualTo: "pendingRequest").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userNameArray.removeAll(keepingCapacity: false)
                    self.heightArray.removeAll(keepingCapacity: false)
                    self.weightArray.removeAll(keepingCapacity: false)
                    self.sexArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.styleArray.removeAll(keepingCapacity: false)
                    self.ageArray.removeAll(keepingCapacity: false)
                    
                    self.nameCombineArray.removeAll(keepingCapacity: false)
                    self.linkArray.removeAll(keepingCapacity: false)
                    self.timeArray.removeAll(keepingCapacity: false)
                    self.stylerCommentArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let userInfo = document.get("Kombin") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Adı" {
                                    guard let name = value as? String else { return }
                                    self.nameCombineArray.append(name)
                                } else if key == "Linki" {
                                    guard let height = value as? String else { return }
                                    self.linkArray.append(height)
                                } else if key == "Saati" {
                                    guard let sex = value as? String else { return }
                                    self.timeArray.append(sex)
                                } else if key == "StilistYorumu" {
                                    guard let email = value as? String else { return }
                                    self.stylerCommentArray.append(email)
                                }
                                else {
                                    print("Kişisel Bilgiler sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                        if let userInfo = document.get("KişiselBilgiler") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Ad" {
                                    guard let name = value as? String else { return }
                                    self.userNameArray.append(name)
                                } else if key == "Boy" {
                                    guard let height = value as? String else { return }
                                    self.heightArray.append(height)
                                } else if key == "Cinsiyet" {
                                    guard let sex = value as? String else { return }
                                    self.sexArray.append(sex)
                                } else if key == "Eposta" {
                                    guard let email = value as? String else { return }
                                    self.emailArray.append(email)
                                } else if key == "Kilo" {
                                    guard let weight = value as? String else { return }
                                    self.weightArray.append(weight)
                                } else if key == "Tarz" {
                                    guard let style = value as? String else { return }
                                    self.styleArray.append(style)
                                }
                                else if key == "Yaş" {
                                    guard let age = value as? String else { return }
                                    self.ageArray.append(age)
                                }
                                else {
                                    print("Kişisel Bilgiler sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    // Get Firestore data for Combines
    func requestedListener(){
        
        let db = Firestore.firestore()
        db.collection("Kullanıcılar").whereField("Request", isEqualTo: "pendingRequest").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.nameCombineArray.removeAll(keepingCapacity: false)
                    self.linkArray.removeAll(keepingCapacity: false)
                    self.timeArray.removeAll(keepingCapacity: false)
                    self.stylerCommentArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let userInfo = document.get("Kombin") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Adı" {
                                    guard let name = value as? String else { return }
                                    self.nameCombineArray.append(name)
                                } else if key == "Linki" {
                                    guard let height = value as? String else { return }
                                    self.linkArray.append(height)
                                } else if key == "Saati" {
                                    guard let sex = value as? String else { return }
                                    self.timeArray.append(sex)
                                } else if key == "StilistYorumu" {
                                    guard let email = value as? String else { return }
                                    self.stylerCommentArray.append(email)
                                }
                                else {
                                    print("Kişisel Bilgiler sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: adminTableViewCell, for: indexPath) as! AdminCell
        
        cell.delegate = self
        cell.titleNameLabel.text = userNameArray[indexPath.item]
        cell.heightLabel.text = heightArray[indexPath.item]
        cell.weightLabel.text = weightArray[indexPath.item]
        cell.sexLabel.text = sexArray[indexPath.item]
        cell.emailLabel.text = emailArray[indexPath.item]
        cell.ageLabel.text = ageArray[indexPath.item]
        cell.styleLabel.text = styleArray[indexPath.item]
        cell.toWhereLabel.text = nameCombineArray[indexPath.item]
        cell.timeLabel.text = linkArray[indexPath.item]
        cell.styleRequestLabel.text = timeArray[indexPath.item]
        cell.noteLabel.text = stylerCommentArray[indexPath.item]
        return cell
    }
    
    // MARK: - Handle operations
    @objc func HandleLogOut(){
        
        guard let currentEmail = Auth.auth().currentUser?.email else { return }
        let fireStoreDatabase = Firestore.firestore()
        let playerIdDictionary = ["email" : currentEmail, "player_id" : "0"] as [String : Any]
        
        fireStoreDatabase.collection("PlayerIdOfStylist").document("\(Auth.auth().currentUser!.email!)").setData(playerIdDictionary, merge: true) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Çıkış Yap", style: .destructive, handler: { (_) in
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
        
        alertController.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
        if let popoverController = alertController.popoverPresentationController {
          popoverController.sourceView = self.view
          popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
          popoverController.permittedArrowDirections = []
        }
        
    }
}
extension AdminVC: AdminDetailCellDelegate{
    func handleCellTapped(for cell: AdminCell) {
        print("Admin Delegated")
        shared.userName = cell.titleNameLabel.text
        shared.height = cell.heightLabel.text
        shared.weight = cell.weightLabel.text
        shared.style = cell.styleLabel.text
        shared.age = cell.ageLabel.text
        shared.email = cell.emailLabel.text
        shared.sex = cell.sexLabel.text
        shared.toWhere = cell.toWhereLabel.text
        shared.time = cell.timeLabel.text
        shared.styleRequest = cell.styleRequestLabel.text
        shared.note = cell.noteLabel.text
        
        let adminDetailVC = AdminDetailVC()
        navigationController?.pushViewController(adminDetailVC, animated: true)
    }
}
