//
//  AdminCell.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit

class AdminCell: UITableViewCell {
    
    var delegate: AdminDetailCellDelegate?
    let titleNameLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let styleLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let heightLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let weightLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let sexLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let emailLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let ageLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let toWhereLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let timeLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let styleRequestLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let noteLabel: UILabel = {
        let lb  = UILabel()
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(titleNameLabel)
        titleNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 26, paddingLeft: 12, paddingBottom: 0, paddingRight: 37, width: 0, height: 0)
        
      
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
