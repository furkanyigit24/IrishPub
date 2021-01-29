//
//  WardrobeVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
class WardrobeVC: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    var langFile = Localization.shared
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: 1.2 * self.view.frame.height)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        return view
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = view.bounds
        view.frame.size = contentViewSize
        return view
    }()
    
    let refreshButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.titleLabel?.font = UIFont.init(name: "SFProText-Regular", size: 17)
        pp.setTitleColor(UIColor(hexString: "#E61515"), for: UIControl.State.normal)
        pp.layer.borderColor = UIColor(hexString: "#707070").cgColor
        pp.layer.borderWidth = 1
        pp.backgroundColor = UIColor(hexString: "#FFFFFF")
        return pp
    }()
    let logOutButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.titleLabel?.font = UIFont.init(name: "SFProText-Regular", size: 17)
        pp.setTitleColor(UIColor(hexString: "#E61515"), for: UIControl.State.normal)
        pp.layer.borderColor = UIColor(hexString: "#707070").cgColor
        pp.layer.borderWidth = 1
        pp.backgroundColor = UIColor(hexString: "#FFFFFF")
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
    let supportLabel: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "destek@fashionline.app"
        rn.textAlignment = .center
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 20)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let getMembershipNow: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 23)
        rn.textColor = UIColor(hexString: "#707070")
        return rn
    }()
    let eMailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let passwordSignUp: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let sexTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let styleTextField: UITextField = {
        let tf = UITextField()
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
    let horizontalLine9: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine10: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    let horizontalLine11: UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor(hexString: "#707070")
        return hl
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        sexTextField.delegate = self
        ageTextField.delegate = self
        styleTextField.delegate = self
        tabBarController?.tabBar.isHidden = true
        configureViewComponents()
    }
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.hideKeyboardWhenTappedAround()
        return true
    }
    //MARK: - View Components
    func configureViewComponents(){
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        // Scroll View
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardForScroll))
        view.addGestureRecognizer(tap)
        
        // FashionLine Name Label
        containerView.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        containerView.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Information
        containerView.addSubview(getMembershipNow)
        getMembershipNow.anchor(top: fashionLineNameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 40, paddingLeft: 38, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        getMembershipNow.text = langFile.format("WardrobeVC", "information")
        // Name Label
        containerView.addSubview(nameTextField)
        nameTextField.anchor(top: getMembershipNow.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        nameTextField.placeholder = langFile.format("WardrobeVC", "nameSurname")
        containerView.addSubview(horizontalLine3)
        horizontalLine3.anchor(top: nameTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Height Label
        containerView.addSubview(heightTextField)
        heightTextField.anchor(top: horizontalLine3.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        heightTextField.placeholder = langFile.format("WardrobeVC", "height")
        containerView.addSubview(horizontalLine4)
        horizontalLine4.anchor(top: heightTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Weight label
        containerView.addSubview(weightTextField)
        weightTextField.anchor(top: horizontalLine4.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        weightTextField.placeholder = langFile.format("WardrobeVC", "weight")
        containerView.addSubview(horizontalLine5)
        horizontalLine5.anchor(top: weightTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Sex Label
        containerView.addSubview(sexTextField)
        sexTextField.anchor(top: horizontalLine5.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        sexTextField.placeholder = langFile.format("WardrobeVC", "sex")
        containerView.addSubview(horizontalLine6)
        horizontalLine6.anchor(top: sexTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Age Label
        containerView.addSubview(ageTextField)
        ageTextField.anchor(top: horizontalLine6.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        ageTextField.placeholder = langFile.format("WardrobeVC", "age")
        containerView.addSubview(horizontalLine7)
        horizontalLine7.anchor(top: ageTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //Style label
        containerView.addSubview(styleTextField)
        styleTextField.anchor(top: horizontalLine7.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        styleTextField.placeholder = langFile.format("WardrobeVC", "styleType")
        containerView.addSubview(horizontalLine8)
        horizontalLine8.anchor(top: styleTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //Refresh Button
        containerView.addSubview(refreshButton)
        refreshButton.anchor(top: horizontalLine8.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 185, height: 28)
        refreshButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        refreshButton.layer.cornerRadius = 14
        refreshButton.setTitle(self.langFile.format("WardrobeVC", "refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        // Logout Button
        containerView.addSubview(logOutButton)
        logOutButton.anchor(top: refreshButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 185, height: 28)
        logOutButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        logOutButton.layer.cornerRadius = 14
        logOutButton.setTitle(self.langFile.format("WardrobeVC", "logOut"), for: .normal)
        logOutButton.addTarget(self, action: #selector(handleLogutTapped), for: .touchUpInside)
        // Supoort Label
        containerView.addSubview(supportLabel)
        supportLabel.anchor(top: logOutButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 28)
        supportLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    // MARK: - Handle Operations
    @objc func dismissKeyboardForScroll() {
        view.endEditing(true)
    }
    @objc func handleLogutTapped(){

        guard let currentEmail = Auth.auth().currentUser?.email else { return }
        let fireStoreDatabase = Firestore.firestore()
        let playerIdDictionary = ["email" : currentEmail, "player_id" : "0"] as [String : Any]
        
        fireStoreDatabase.collection("PlayerId").document("\(Auth.auth().currentUser!.email!)").setData(playerIdDictionary, merge: true) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: self.langFile.format("WardrobeVC", "logOut"), style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
                print("Succesfully loged user out")
                
            } catch{
                print("Failed signed out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: self.langFile.format("WardrobeVC", "cancel"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            alertController.addAction(UIAlertAction(title: self.langFile.format("WardrobeVC", "cancel"), style: .default, handler: nil))
        }
    }
    @objc func refreshTapped(){
        guard let nameLabel = nameTextField.text else { return }
        guard let heightLabel = heightTextField.text else { return }
        guard let sexLabel = sexTextField.text else { return }
        guard let weightLabel = weightTextField.text else { return }
        guard let styleLabel = styleTextField.text else { return }
        guard let ageLabel = ageTextField.text else { return }
        
        let db = Firestore.firestore()
        let uuidDocument = UUID().uuidString
        
        let userData: [String: Any] = [
            "KişiselBilgiler": [
                "Ad": nameTextField.text,
                "Boy": heightTextField.text,
                "Cinsiyet": sexTextField.text,
                "Kilo": weightTextField.text,
                "Tarz": styleTextField.text,
                "Yaş": ageTextField.text
            ],
            "Kombin": [
                "Adı": nameTextField.text,
                "Linki": nameTextField.text,
                "Saati": nameTextField.text,
                "StilistYorumu": nameTextField.text
            ],
        ]
        
        if nameLabel != "" && heightLabel != "" && sexLabel != "" && weightLabel != "" && styleLabel != "" && ageLabel != ""{
            
            db.collection("Kullanıcılar").document("\(Auth.auth().currentUser!.email!.uppercased())").setData(userData, merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            _ = self.navigationController?.popViewController(animated: true)
        }
        else {
            makeAlert(titleInput: self.langFile.format("WardrobeVC", "error"), messageInput: self.langFile.format("WardrobeVC", "fill"))
        }
    }
}
