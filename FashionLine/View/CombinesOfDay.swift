//
//  CombinesOfDay.swift
//  FashionLine
//
//  Created by Furkan Y. on 14.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
let combinesSubCellId : String = "combinesSubCellID"

class CombinesOfDay: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var shared = Users.sharedInstance
    var nameArray = [String]()
    var linkArray = [String]()
    var imageArray = [String]()
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
        lb.font = UIFont.init(name: "SFProDisplay-Regular", size: 30)
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
        db.collection("Kombinler").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.nameArray.removeAll(keepingCapacity: false)
                    self.linkArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let userInfo = document.get("Kombin") as? [String: Any]{
                            for (key,value) in userInfo {
                                if key == "Ad" {
                                    guard let name = value as? String else { return }
                                    self.nameArray.append(name)
                                }
                                else if key == "Link" {
                                    guard let link = value as? String else { return }
                                    self.linkArray.append(link)
                                }
                                else if key == "Resim" {
                                    guard let image = value as? String else { return }
                                    self.imageArray.append(image)
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
        
        cell.delegate = self
        cell.backgroundColor = .white // yellow
        cell.titleBottomLabel.text = nameArray[indexPath.item]
        cell.linkLabel.text = linkArray[indexPath.item]
        cell.postImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.item]))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.28
        let height = frame.height * 0.55
        return CGSize(width: width, height: height)
    }
}
extension CombinesOfDay: CombinesOfDayDelegate{
    func handleCellTapped(for cell: CombinesSubCustomCell) {
        shared.linkLabel = cell.linkLabel.text
        shared.linkArray.append(contentsOf: linkArray)
        print("\(shared.linkLabel)")
        guard let url = URL(string: shared.linkLabel ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
class CombinesSubCustomCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    var delegate: CombinesOfDayDelegate?
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
    let linkLabel: UILabel = {
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
        let tappedCell: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCellTapped))
            self.addGestureRecognizer(tappedCell)
    }
    // MARK: -- Handling Operations
           @objc func handleCellTapped() {
            delegate?.handleCellTapped(for: self)
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
