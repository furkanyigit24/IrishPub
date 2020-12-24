//
//  CombineVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
var setCombine: Bool?
class CombineVC: UIViewController {
    let fashionLineNameLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "FashionLine"
        rn.font = UIFont.init(name: "SFProDisplay-Bold", size: 34)
        rn.textColor = UIColor(hexString: "#E61515", alpha: 0.82)
        return rn
    }()
    let welcomeLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Merhaba"
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 34)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let eMailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nereye Gideceksin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Saat kaçta gideceksin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nasıl bir kombin istersin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Eklemek istediğin notlar"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let signUpButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setTitle("Kombin oluştur", for: .normal)
        pp.titleLabel?.font = UIFont.init(name: "SFProText-Regular", size: 17)
        pp.setTitleColor(UIColor(hexString: "#E61515"), for: UIControl.State.normal)
        pp.layer.borderColor = UIColor(hexString: "#707070").cgColor
        pp.layer.borderWidth = 1
        pp.backgroundColor = UIColor(hexString: "#FFFFFF")
        return pp
    }()
    let imageButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "artistImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return pp
    }()
    let artistLabel: UILabel = {
        let pp = UILabel()
        pp.font = UIFont.init(name: "SFProDisplay-Regular", size: 13)
        pp.text = "Stil Mentorları"
        return pp
    }()
    let signedUpMainMessage: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Harika!"
        rn.textAlignment = .center
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 40)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let signedUpSubMessage: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Mentorlarımız senin içinen güzel kombinleri seçmeye başladılar bile!"
        rn.textAlignment = .center
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 23)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let horizontalLine1: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine2: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine3: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine4: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine5: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setUpViews()
        signUpButton.addTarget(self, action: #selector(sendCombine), for: .touchUpInside)
    }
    // MARK: - Set Up Views
    fileprivate func setUpViews() {
        // FashionLine Name Label
        view.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        view.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Image button
        view.addSubview(imageButton)
        imageButton.anchor(top: horizontalLine1.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 38.5, paddingLeft: 0, paddingBottom: 0, paddingRight: 26, width: 59, height: 65)
        // Artist label
        view.addSubview(artistLabel)
        artistLabel.anchor(top: imageButton.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 26, width: 0, height: 0)
        // Welcome Label
        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 149, paddingLeft: 30.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Email Label
        view.addSubview(eMailTextField)
        eMailTextField.anchor(top: artistLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine2)
        horizontalLine2.anchor(top: eMailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Name Label
        view.addSubview(nameTextField)
        nameTextField.anchor(top: horizontalLine2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine3)
        horizontalLine3.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Height Label
        view.addSubview(heightTextField)
        heightTextField.anchor(top: horizontalLine3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine4)
        horizontalLine4.anchor(top: heightTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Weight label
        view.addSubview(weightTextField)
        weightTextField.anchor(top: horizontalLine4.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine5)
        horizontalLine5.anchor(top: weightTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        //SignUp Button
        view.addSubview(signUpButton)
        signUpButton.anchor(top: horizontalLine5.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 280, height: 44)
        signUpButton.layer.cornerRadius = 22
    }
    @objc func sendCombine(){
        // Navigation Contoller
        setCombine = true
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        signUpButton.isHidden = true
        horizontalLine5.isHidden = true
        weightTextField.isHidden = true
        horizontalLine4.isHidden = true
        heightTextField.isHidden = true
        horizontalLine3.isHidden = true
        imageButton.isHidden = true
        artistLabel.isHidden = true
        welcomeLabel.isHidden = true
        eMailTextField.isHidden = true
        horizontalLine2.isHidden = true
        nameTextField.isHidden = true
        // FashionLine Name Label
        view.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        view.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Main message & Sub message
        view.addSubview(signedUpMainMessage)
        signedUpMainMessage.anchor(top: horizontalLine1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 156.5, paddingLeft: 109, paddingBottom: 0, paddingRight: 0, width: 118, height: 48)
        signedUpMainMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(signedUpSubMessage)
        signedUpSubMessage.anchor(top: signedUpMainMessage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 45, paddingBottom: 0, paddingRight: 0, width: 280, height: 84)
        signedUpSubMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
