//
//  HeaderView.swift
//  FashionLine
//
//  Created by Furkan Y. on 9.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit

class HeaderView: UIView {

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
    }
}
