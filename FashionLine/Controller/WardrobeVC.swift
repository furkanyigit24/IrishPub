//
//  WardrobeVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit

class WardrobeVC: UIViewController {
    let profilePicture: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "profilePicture")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return pp
    }()
    let signUpButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setTitle("Üye Ol", for: .normal)
        pp.titleLabel?.font = UIFont.init(name: "SFProText-Regular", size: 17)
        pp.setTitleColor(UIColor(hexString: "#E61515"), for: UIControl.State.normal)
        pp.layer.borderColor = UIColor(hexString: "#707070").cgColor
        pp.layer.borderWidth = 1
        pp.backgroundColor = UIColor(hexString: "#FFFFFF")
        return pp
    }()
    let quickLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Hızlı Kayıt"
        rn.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 23)
        rn.textColor = UIColor(hexString: "#707070")
        return rn
    }()
    let quickGoogleButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "signUpGoogle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return pp
    }()
    let quickAppleButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "signUpApple")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
    let welcomeLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Hoşgeldin!"
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 34)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let eMailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-posta"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Adın"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Boyun"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Kilon"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    
    let sexTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Cinsiyet"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Yaşın"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let styleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ne tür giyinmeyi seversin"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
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
    let horizontalLine6: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine7: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine8: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    }
    //MARK: - View Components
    func configureViewComponents() {
        
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        // Profile picture
        view.addSubview(profilePicture)
        profilePicture.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 87, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 30, height: 30)
        profilePicture.layer.cornerRadius = 15
        // FashionLine Name Label
        view.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        view.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Welcome Label
        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 149, paddingLeft: 30.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Quick Label
        view.addSubview(quickLabel)
        quickLabel.anchor(top: welcomeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 31, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Quick Google and Apple
         view.addSubview(quickGoogleButton)
               quickGoogleButton.anchor(top: quickLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 38, paddingBottom: 0, paddingRight: 0, width: 217, height: 39)
        view.addSubview(quickAppleButton)
        quickAppleButton.anchor(top: quickGoogleButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 38, paddingBottom: 0, paddingRight: 0, width: 217, height: 39)
        // Email Label
        view.addSubview(eMailTextField)
        eMailTextField.anchor(top: quickAppleButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine2)
        horizontalLine2.anchor(top: eMailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Name Label
        view.addSubview(nameTextField)
        nameTextField.anchor(top: horizontalLine2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine3)
        horizontalLine3.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Height Label
        view.addSubview(heightTextField)
        heightTextField.anchor(top: horizontalLine3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine4)
        horizontalLine4.anchor(top: heightTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Weight label
        view.addSubview(weightTextField)
        weightTextField.anchor(top: horizontalLine4.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine5)
        horizontalLine5.anchor(top: weightTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Sex Label
        view.addSubview(sexTextField)
        sexTextField.anchor(top: horizontalLine5.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine6)
        horizontalLine6.anchor(top: sexTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Age Label
        view.addSubview(ageTextField)
        ageTextField.anchor(top: horizontalLine6.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine7)
        horizontalLine7.anchor(top: ageTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //Style label
        view.addSubview(styleTextField)
        styleTextField.anchor(top: horizontalLine7.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        view.addSubview(horizontalLine8)
        horizontalLine8.anchor(top: styleTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //SignUp Button
        view.addSubview(signUpButton)
        signUpButton.anchor(top: horizontalLine8.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 280, height: 44)
        signUpButton.layer.cornerRadius = 22
    }
}
