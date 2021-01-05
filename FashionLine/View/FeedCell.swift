//
//  FeedCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
let subCellId : String = "subCellID"

class FeedCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var nameCombineArray = [String]()
    var stylerCommentArray = [String]()
    var linkArray = [String]()
    var timeArray = [String]()
    var bottomTitle = Users.sharedInstance
    let collectionView : UICollectionView = {
        // init the layout
        let layout = UICollectionViewFlowLayout()
        // set the direction to be horizontal
        layout.scrollDirection = .horizontal
        // the instance of collectionView
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Activate constaints
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    let titleLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Section Title"
        lb.font = UIFont.init(name: "SFProDisplay-Regular", size: 34)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Yeni kombininiz geldi! 12dk önce"
        lb.font = UIFont.init(name: "SFProDisplay-Regular", size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationLabelNotSentYet: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.init(name: "SFProDisplay-Bold", size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationSubLabelNotSentYet: UILabel = {
        let lb  = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let titleBottomLabel: UILabel = {
        let lb  = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.snapshotListener()
    }
    // Check the data whether reguested or not
    func snapshotListener(){
        let db = Firestore.firestore()
        self.requestedListener()
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
                    if key == "Request" {
                        guard let val = value as? String else { return }
                        switch val {
                        case "requested":
                            self.requestedListener()
                            self.setupViews()
                        case "notRequested":
                            self.NotSentRequest()
                        case "pendingRequest":
                            self.pendingRequest()
                        default:
                            self.NotSentRequest()
                            print("Default")
                        }
                        self.collectionView.reloadData()
                    }
                    self.collectionView.reloadData()
                }
        }
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
                                    default:
                                        print("Default")
                                    }
                                }
                            }
                        }
                    }
                }
            self.collectionView.reloadData()
        }
    }
    // Pending View
    fileprivate func pendingRequest() {
        combineNotificationLabel.isHidden = true
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabelNotSentYet)
        combineNotificationLabelNotSentYet.text = "Harika! Kombin isteğini Aldık."
        combineNotificationLabelNotSentYet.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 49, paddingLeft: 75, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationSubLabelNotSentYet)
        combineNotificationSubLabelNotSentYet.text = "Hemen aşağıdaki Kombin sekmesine tıklayarak kombin talebinde bulunabilirsin!"
        combineNotificationSubLabelNotSentYet.anchor(top: combineNotificationLabelNotSentYet.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 75, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        //Collection View
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    // Not Requested View
    fileprivate func NotSentRequest() {
        combineNotificationLabel.isHidden = true
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabelNotSentYet)
        combineNotificationLabelNotSentYet.text = "Henüz Bir istekte bulunmandın."
        combineNotificationLabelNotSentYet.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 49, paddingLeft: 75, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationSubLabelNotSentYet)
        combineNotificationSubLabelNotSentYet.text = "Hemen aşağıdaki Kombin sekmesine tıklayarak kombin talebinde bulunabilirsin!"
        combineNotificationSubLabelNotSentYet.anchor(top: combineNotificationLabelNotSentYet.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 75, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        //Collection View
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    // Requested View
    func setupViews(){
        combineNotificationLabel.isHidden = false
        collectionView.isHidden = false
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(titleBottomLabel)
        titleBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        //Collection View
        collectionView.register(SubCustomCell.self, forCellWithReuseIdentifier: subCellId)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white //purple
        collectionView.anchor(top: combineNotificationLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameCombineArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! SubCustomCell
        
        cell.backgroundColor = .white // yellow
        cell.titleBottomLabel.text = nameCombineArray[indexPath.item]
        //            if indexPath.row == 0{
        //                cell.titleBottomLabel.text = "H&M"
        //            }
        //            else if indexPath.row == 1{
        //                cell.titleBottomLabel.text = "Zara"
        //            }
        //            else if indexPath.row == 2{
        //                cell.titleBottomLabel.text = "Bershka"
        //            }
        //            else if indexPath.row == 3{
        //                cell.titleBottomLabel.text = "Stradivarius"
        //            }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.28
        let height = frame.height * 0.55
        return CGSize(width: width, height: height)
    }
}
