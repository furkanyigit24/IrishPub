//
//  FeedCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

let subCellId : String = "subCellID"
protocol TransferDelegate{
    func transferValueOfRequest(request: String)
}

class FeedCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    var langFile = Localization.shared
    var delegate: CombinesSuggestionsHeaderTDelegate?
    var transferDelegate: TransferDelegate?
    var shared = Users.sharedInstance
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
        lb.font = UIFont.init(name: "SFProDisplay-Regular", size: 30)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationLabel: UILabel = {
        let lb  = UILabel()
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
    let detailsButton: UIButton = {
        let button = UIButton(type: .system)
        return button
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
                            self.transferDelegate?.transferValueOfRequest(request: "requested")
                            self.requestedListener()
                            self.setupViews()
                        case "notRequested":
                            self.transferDelegate?.transferValueOfRequest(request: "notRequested")
                            self.NotSentRequest()
                        case "pendingRequest":
                            self.transferDelegate?.transferValueOfRequest(request: "pendingRequest")
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
            self.collectionView.reloadData()
        }
    }
    // Pending View
    fileprivate func pendingRequest() {
        combineNotificationLabel.isHidden = true
        collectionView.removeFromSuperview()
        detailsButton.removeFromSuperview()
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabelNotSentYet)
        combineNotificationLabelNotSentYet.text = langFile.format("FeedCell", "sent")
        combineNotificationLabelNotSentYet.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 49, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationSubLabelNotSentYet)
        combineNotificationSubLabelNotSentYet.text = langFile.format("FeedCell", "mentor")
        combineNotificationSubLabelNotSentYet.anchor(top: combineNotificationLabelNotSentYet.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        //Collection View
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    // Not Requested View
    fileprivate func NotSentRequest() {
        combineNotificationLabel.isHidden = true
        collectionView.removeFromSuperview()
        detailsButton.removeFromSuperview()
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabelNotSentYet)
        combineNotificationLabelNotSentYet.text = langFile.format("FeedCell", "notYet")
        combineNotificationLabelNotSentYet.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 49, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationSubLabelNotSentYet)
        combineNotificationSubLabelNotSentYet.text = langFile.format("FeedCell", "subLabel")
        combineNotificationSubLabelNotSentYet.anchor(top: combineNotificationLabelNotSentYet.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 25, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        //Collection View
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    // Requested View
    func setupViews(){
        combineNotificationLabel.isHidden = false
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        combineNotificationLabel.text = langFile.format("FeedCell", "arrived")
        addSubview(titleBottomLabel)
        titleBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        //Collection View
        collectionView.register(SubCustomCell.self, forCellWithReuseIdentifier: subCellId)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white //purple
        collectionView.anchor(top: combineNotificationLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Gesture recognizer
        titleLabel.isUserInteractionEnabled = true
        combineNotificationLabel.isUserInteractionEnabled = true
        let tappedHeader: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTapped))
        let tappedNotificationHeader: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleNotificationHeaderTapped))
        titleLabel.addGestureRecognizer(tappedHeader)
        combineNotificationLabel.addGestureRecognizer(tappedNotificationHeader)
        // Details
        addSubview(detailsButton)
        detailsButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 10)
        let attributedTitle = NSMutableAttributedString(string: self.langFile.format("FeedCell", "details"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        detailsButton.setAttributedTitle(attributedTitle, for: .normal)
        detailsButton.addTarget(self, action: #selector(handleDetailHeaderTapped), for: .touchUpInside)
    }
    // MARK: -- Handling Operations
    @objc func handleHeaderTapped() {
        delegate?.handleHeaderCellTapped(for: self)
    }
    @objc func handleNotificationHeaderTapped() {
        delegate?.handleHeaderCellTapped(for: self)
    }
    @objc func handleDetailHeaderTapped() {
        delegate?.handleHeaderCellTapped(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameCombineArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! SubCustomCell
        cell.delegate = self
        cell.backgroundColor = .white // yellow
        cell.titleBottomLabel.text = nameCombineArray[indexPath.item]
        cell.linkLabel.text = linkArray[indexPath.item]
        cell.postImageView.sd_setImage(with: URL(string: self.timeArray[indexPath.item]))
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
extension FeedCell: SubCustomCellDelegate{
    func handleCellTapped(for cell: SubCustomCell) {
        shared.linkLabel = cell.linkLabel.text
        shared.linkArray.append(contentsOf: linkArray)
        print("\(shared.linkLabel)")
        guard let url = URL(string: shared.linkLabel ?? "") else { return }
        UIApplication.shared.open(url)
    }
}
