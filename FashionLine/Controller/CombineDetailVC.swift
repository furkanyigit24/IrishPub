//
//  CombineDetailVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 9.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
let combineDetailCell = "CombineDetailCell"

class CombineDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shared = Users.sharedInstance
    var nameCombineArray = [String]()
    var stylerCommentArray = [String]()
    var linkArray = [String]()
    var timeArray = [String]()
    
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
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 375, height: 127)
        
        view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.register(CombineDetailCell.self, forCellReuseIdentifier: combineDetailCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 175
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
        // Call Firebase
        requestedListener()
    }
    // Get Firestore data for Combines
    func requestedListener(){
        let db = Firestore.firestore()
        guard var currentEmail = Auth.auth().currentUser?.email?.uppercased() as? String else{ return }
        db.collection("Kullanıcılar").document(currentEmail)
            .addSnapshotListener { documentSnapshot, error in
                
                self.nameCombineArray.removeAll(keepingCapacity: false)
                self.linkArray.removeAll(keepingCapacity: false)
                self.timeArray.removeAll(keepingCapacity: false)
                self.stylerCommentArray.removeAll(keepingCapacity: false)
                
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("XXX \(data)")
                guard let newDictionary = data as? [String:Any] else { return }
                for (key,value) in newDictionary {
                    guard let combinesDict = newDictionary as? [String:Any] else { return }
                    if key == "Combines"{
                        guard let valueDict = value as? [String:Any] else { return }
                        for (key,value) in valueDict {
                            if key == "1.kombin" || key == "2.kombin" || key == "3.kombin"{
                                guard let stringKey = value as? [String:String] else { return }
                                for (key,value) in stringKey {
                                    guard let namekey = key as? String else { return }
                                    switch namekey {
                                    case "Ad":
                                        self.nameCombineArray.append(value)
                                    case "Linki":
                                        self.linkArray.append(value)
                                    case "Saati":
                                        self.timeArray.append(value)
                                    case "StilistYorumu":
                                        self.stylerCommentArray.append(value)
                                    default:
                                        print("Default")
                                    }
                                }
                            }
                        }
                    }
                }
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: combineDetailCell, for: indexPath) as! CombineDetailCell
        
        cell.titleLabel.text = nameCombineArray[indexPath.item]
        cell.subTitleLabel.text = stylerCommentArray[indexPath.item]
        cell.postImageView.sd_setImage(with: URL(string: self.timeArray[indexPath.item]))
        cell.linkLabel.text = linkArray[indexPath.item]
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
}
extension CombineDetailVC: CombineDetailCellDelegate {
    func handleCellTapped(for cell: CombineDetailCell) {
        shared.linkLabel = cell.linkLabel.text
        shared.linkArray.append(contentsOf: linkArray)
        print("\(shared.linkLabel)")
        guard let url = URL(string: shared.linkLabel ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
