//
//  CombineDetailCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 9.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit

class CombineDetailCell: UITableViewCell {
    
    var delegate: CombineDetailCellDelegate?
    
    lazy var postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    let titleLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let subTitleLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 26, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        postImageView.layer.cornerRadius = 20
        postImageView.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: postImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 26, paddingLeft: 12, paddingBottom: 0, paddingRight: 37, width: 0, height: 0)
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: postImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingBottom: 0, paddingRight: 37, width: 0, height: 0)
        // Gesture Recognizer for cell
        let tappedCell: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCellTapped))
        self.addGestureRecognizer(tappedCell)
    }
    // MARK: -- Handling Operations
    @objc func handleCellTapped() {
        delegate?.handleCellTapped(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
