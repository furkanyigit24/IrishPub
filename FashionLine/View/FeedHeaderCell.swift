//
//  FeedHeaderCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 11.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit

class FeedHeaderCell: UICollectionViewCell {
    var delegate: FeedHeaderCellDelegate?
    let profilePicture: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "profilePicture")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return pp
    }()
    let fashionLineNameLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "FashionLine"
        rn.font = UIFont.init(name: "SFProDisplay-Bold", size: 34)
        rn.textColor = UIColor(hexString: "#E61515", alpha: 0.82)
        return rn
    }()
    let horizontalLine: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpConstraints(){
        // FashionLine Name Label
        addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        // Horizontal Line
        addSubview(horizontalLine)
        horizontalLine.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        addSubview(profilePicture)
        profilePicture.anchor(top: nil, left: nil, bottom: horizontalLine.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 9.5, paddingRight: 24, width: 30, height: 30)
        profilePicture.layer.cornerRadius = 15
        profilePicture.addTarget(self, action: #selector(handleProfilePicTapped), for: .touchUpInside)
    }
    // MARK: - Handle Operations
    @objc func handleProfilePicTapped(){
        delegate?.handleProfilePicTapped(for: self)
    }
}
