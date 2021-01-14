//
//  AdminDetailVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 10.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit

class AdminDetailVC: UIViewController {
    var shared = Admin.sharedInstance
    
    let userNameLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 24)
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let combineRequestLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 20)
        tf.text = "Kombin İsteği"
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let emailLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let heightLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let weightLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let sexLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let ageLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let styleLabel: UILabel = {
           let tf = UILabel()
           tf.numberOfLines = 0
           tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
           tf.textColor = UIColor(hexString: "#000000", alpha: 100)
           return tf
       }()
    let toWhereLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let timeLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let styleRequestLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let noteLabel: UILabel = {
        let tf = UILabel()
        tf.numberOfLines = 0
        tf.font = UIFont.init(name: "SFProText-Medium", size: 18)
        tf.textColor = UIColor(hexString: "#000000", alpha: 100)
        return tf
    }()
    let combineDesignButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Kombin ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.red])
        attributedTitle.append(NSAttributedString(string: "oluştur", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.red]))
        button.addTarget(self, action: #selector(handleCombineDesign), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewComponents()
    }
    func configureViewComponents() {
        
        view.addSubview(userNameLabel)
        userNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 126, paddingLeft: 26, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        userNameLabel.text = shared.userName
        ageLabel.text = "Yaş: \(shared.age ?? "Bilgi Girilmedi")"
        heightLabel.text = "Boy: \(shared.height ?? "Bilgi Girilmedi")"
        weightLabel.text = "Kilo: \(shared.weight ?? "Bilgi Girilmedi")"
        sexLabel.text = "Cinsiyet: \(shared.sex ?? "Bilgi Girilmedi")"
        styleLabel.text = "Tarz: \(shared.style ?? "Bilgi Girilmedi")"
        
        toWhereLabel.text = shared.toWhere
        timeLabel.text = shared.time
        styleRequestLabel.text = shared.styleRequest
        noteLabel.text = shared.note
        
        let stackView1 = UIStackView(arrangedSubviews: [ageLabel, heightLabel, weightLabel])
        let stackView2 = UIStackView(arrangedSubviews: [sexLabel, styleLabel])
        let stackView3 = UIStackView(arrangedSubviews: [toWhereLabel, timeLabel, styleRequestLabel, noteLabel])
        
        stackView1.axis = .horizontal
        stackView1.spacing = 20
        stackView1.distribution = .fillEqually
        
        stackView2.axis = .horizontal
        stackView2.spacing = 20
        stackView2.distribution = .fillEqually
        
        stackView3.axis = .vertical
        stackView3.spacing = 10
        stackView3.distribution = .fillEqually
        
        view.addSubview(stackView1)
        stackView1.anchor(top: userNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        view.addSubview(stackView2)
        stackView2.anchor(top: stackView1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        view.addSubview(combineRequestLabel)
        combineRequestLabel.anchor(top: stackView2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 22, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        view.addSubview(stackView3)
        stackView3.anchor(top: combineRequestLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 42, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        view.addSubview(combineDesignButton)
        combineDesignButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: 50, paddingRight: 50, width: 0, height: 50)
        combineDesignButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func handleCombineDesign(){
        
        let combineDesignVC = CombineDesignVC()
        navigationController?.pushViewController(combineDesignVC, animated: true)
    }
}
