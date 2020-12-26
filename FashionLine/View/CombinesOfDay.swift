//
//  CombinesOfDay.swift
//  FashionLine
//
//  Created by Furkan Y. on 14.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
let combinesSubCellId : String = "combinesSubCellID"

class CombinesOfDay: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var shared = Users.sharedInstance
    var nameArray = [String]()
    var linkArray = [String]()
    var timeArray = [String]()
    var heightArray = [String]()
    var genderArray = [String]()
    var ePostaArray = [String]()
    var weightArray = [String]()
    var styleArray = [String]()
    var ageArray = [String]()
    var passwordArray = [String]()
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
    let combineCommentButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "plusButton"), for: .normal)
        return pp
    }()
    let combineCommentLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Kombin Yorumlat"
        lb.numberOfLines = 0
        lb.font = UIFont.init(name: "SFProText-Medium", size: 10)
        lb.textColor = UIColor(hexString: "#8E8E93", alpha: 1)
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
        collectionView.register(CombinesSubCustomCell.self, forCellWithReuseIdentifier: combinesSubCellId)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineCommentButton)
        combineCommentButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 30, height: 30)
        combineCommentButton.layer.cornerRadius = 15
        addSubview(combineCommentLabel)
        combineCommentLabel.anchor(top: combineCommentButton.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 1, paddingLeft: 0, paddingBottom: 0, paddingRight: 1, width: 0, height: 0)
        addSubview(titleBottomLabel)
        titleBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        setupViews()
        getDataFromFirestore()

    }
    func setupViews(){
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white // purple
        collectionView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    // MARK: -- Firestore Data
    func getDataFromFirestore(){
        
        let db = Firestore.firestore()
        db.collection("Kullanıcılar").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.nameArray.removeAll(keepingCapacity: false)
                    self.heightArray.removeAll(keepingCapacity: false)
                    self.genderArray.removeAll(keepingCapacity: false)
                    self.ePostaArray.removeAll(keepingCapacity: false)
                    self.weightArray.removeAll(keepingCapacity: false)
                    self.styleArray.removeAll(keepingCapacity: false)
                    self.ageArray.removeAll(keepingCapacity: false)
                    self.passwordArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let userInfo = document.get("KişiselBilgiler") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Ad" {
                                    guard let name = value as? String else { return }
                                    self.nameArray.append(name)
                                }
                                else if key == "Boy" {
                                    guard let height = value as? String else { return }
                                    self.heightArray.append(height)
                                }
                                else if key == "Cinsiyet" {
                                    guard let gender = value as? String else { return }
                                    self.genderArray.append(gender)
                                }
                                else if key == "Eposta" {
                                    guard let eMail = value as? String else { return }
                                    self.ePostaArray.append(eMail)
                                }
                                else if key == "Kilo" {
                                    guard let weight = value as? String else { return }
                                    self.weightArray.append(weight)
                                }
                                else if key == "Tarz" {
                                    guard let style = value as? String else { return }
                                    self.styleArray.append(style)
                                }
                                else if key == "Yaş" {
                                    guard let age = value as? String else { return }
                                    self.ageArray.append(age)
                                }
                                else if key == "Şifre" {
                                    guard let password = value as? String else { return }
                                    self.passwordArray.append(password)
                                }
                                else {
                                    print("Kişisel Bilgiler sözlüğü Swift içersinde oluşturulan dizilere aktarılamadı")
                                }
                            }
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: combinesSubCellId, for: indexPath) as! CombinesSubCustomCell

        cell.backgroundColor = .white // yellow
        cell.titleBottomLabel.text = nameArray[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.28
        let height = frame.height * 0.55
        return CGSize(width: width, height: height)
    }
}
class CombinesSubCustomCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    lazy var postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    let titleBottomLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.width
        let height = frame.height
        addSubview(postImageView)
        addSubview(titleBottomLabel)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 1, paddingBottom: 20, paddingRight: 1, width: width, height: height)
        postImageView.layer.cornerRadius = 20
        postImageView.clipsToBounds = true
        titleBottomLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 1, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! CombinesSubCustomCell
        return cell
    }
}
