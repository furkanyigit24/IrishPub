//
//  FeedCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
let subCellId : String = "subCellID"

class FeedCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineCommentButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.backgroundColor = UIColor(hexString: "#707070")
        return pp
    }()
    let combineCommentLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Kombin Yorumlat"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let combineNotificationLabel: UILabel = {
        let lb  = UILabel()
        lb.text = "Yeni kombininiz geldi! 12dk önce"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.font = UIFont.boldSystemFont(ofSize: 14)
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
        collectionView.register(SubCustomCell.self, forCellWithReuseIdentifier: subCellId)
        setupViews()
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(combineCommentButton)
        combineCommentButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 30, height: 30)
        combineCommentButton.layer.cornerRadius = 15
        addSubview(combineCommentLabel)
        combineCommentLabel.anchor(top: combineCommentButton.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 1, width: 0, height: 0)
        addSubview(combineNotificationLabel)
        combineNotificationLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(titleBottomLabel)
        titleBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
    }
    func setupViews(){
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subCellId, for: indexPath) as! SubCustomCell

        cell.backgroundColor = .yellow
            if indexPath.row == 0{
                cell.titleBottomLabel.text = "H&M"
            }
            else if indexPath.row == 1{
                cell.titleBottomLabel.text = "Zara"
            }
            else if indexPath.row == 2{
                cell.titleBottomLabel.text = "Bershka"
            }
            else if indexPath.row == 3{
                cell.titleBottomLabel.text = "Stradivarius"
            }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.28
        let height = frame.height * 0.55
        return CGSize(width: width, height: height)
    }
}
