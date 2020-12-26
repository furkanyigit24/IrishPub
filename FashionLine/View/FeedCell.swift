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
        lb.text = "Henüz bir istek oluşturmadın."
        lb.textAlignment = .center
        lb.font = UIFont.init(name: "SFProDisplay-Bold", size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationSubLabelNotSentYet: UILabel = {
        let lb  = UILabel()
        lb.text = "Hemen aşağıdaki Kombin sekmesine tıklayarak kombin talebinde bulunabilirsin!"
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
            setupViews()
       fetchFirebaseData()
            //NotSentRequest()
   
    }
    func fetchFirebaseData() {
        
        let db = Firestore.firestore()
        db.collection("Kullanıcılar").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.nameCombineArray.removeAll(keepingCapacity: false)
                    self.linkArray.removeAll(keepingCapacity: false)
                    self.timeArray.removeAll(keepingCapacity: false)
                    self.stylerCommentArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let userInfoCombine = document.get("Kombin") as? [String: Any]{
                            for (key,value) in userInfoCombine {
                                if key == "Adı" {
                                    guard let nameCombine = value as? String else { return }
                                    self.nameCombineArray.append(nameCombine)
                                }
                                else if key == "Linki" {
                                    guard let link = value as? String else { return }
                                    self.linkArray.append(link)
                                }
                                else if key == "Saati" {
                                    guard let time = value as? String else { return }
                                    self.timeArray.append(time)
                                }
                                else if key == "StilistYorumu" {
                                    guard let stylerComment = value as? String else { return }
                                    self.stylerCommentArray.append(stylerComment)
                                }
                                else {
                                    print("Kombin sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
            self.collectionView.reloadData()
        }
    }
    fileprivate func NotSentRequest() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabelNotSentYet)
        combineNotificationLabelNotSentYet.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 49, paddingLeft: 75, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationSubLabelNotSentYet)
        combineNotificationSubLabelNotSentYet.anchor(top: combineNotificationLabelNotSentYet.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 75, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
    }
    
    func setupViews(){
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
