//
//  WardrobeVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
var flag: String?
class WardrobeVC: UIViewController {
    // MARK: - Properties
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
    let signInButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setTitle("Giriş Yap", for: .normal)
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
        rn.text = "Giriş Yap"
        rn.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 23)
        rn.textColor = UIColor(hexString: "#707070")
        return rn
    }()
    let eMailTextFieldForSignIn: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-posta"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
    }()
    let passwordSignIn: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Şifre"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic", size: 14)
        return tf
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
    let getMembershipNow: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Üye Değilsen Hemen Üye Ol!"
        rn.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 23)
        rn.textColor = UIColor(hexString: "#707070")
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
    let passwordSignUp: UITextField = {
        let tf = UITextField()
        tf.placeholder = "şifre"
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
        tabBarController?.tabBar.isHidden = true
        configureViewComponents()
    }
    //MARK: - View Components
    func configureViewComponents(){
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        // Scroll View
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        // FashionLine Name Label
        containerView.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        containerView.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Welcome Label
        containerView.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 130, paddingLeft: 30.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // Quick Label
        containerView.addSubview(quickLabel)
        quickLabel.anchor(top: welcomeLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 31, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // SignIn and Password
        containerView.addSubview(eMailTextFieldForSignIn)
        eMailTextFieldForSignIn.anchor(top: quickLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 217, height: 39)
        containerView.addSubview(horizontalLine9)
        horizontalLine9.anchor(top: eMailTextFieldForSignIn.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        containerView.addSubview(passwordSignIn)
        passwordSignIn.anchor(top: eMailTextFieldForSignIn.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 217, height: 39)
        containerView.addSubview(horizontalLine10)
        horizontalLine10.anchor(top: passwordSignIn.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // SignIn Button
        containerView.addSubview(signInButton)
        signInButton.anchor(top: passwordSignIn.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 18.5, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 280, height: 44)
        signInButton.layer.cornerRadius = 22
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        // Get membership now
        containerView.addSubview(getMembershipNow)
        getMembershipNow.anchor(top: signInButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 40, paddingLeft: 38, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        // Email Label
        containerView.addSubview(eMailTextField)
        eMailTextField.anchor(top: getMembershipNow.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        containerView.addSubview(horizontalLine2)
        horizontalLine2.anchor(top: eMailTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Password for SignUp
        containerView.addSubview(passwordSignUp)
        passwordSignUp.anchor(top: horizontalLine2.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        containerView.addSubview(horizontalLine11)
        horizontalLine11.anchor(top: passwordSignUp.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Name Label
        containerView.addSubview(nameTextField)
        nameTextField.anchor(top: horizontalLine11.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine3)
        horizontalLine3.anchor(top: nameTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Height Label
        containerView.addSubview(heightTextField)
        heightTextField.anchor(top: horizontalLine3.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine4)
        horizontalLine4.anchor(top: heightTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Weight label
        containerView.addSubview(weightTextField)
        weightTextField.anchor(top: horizontalLine4.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine5)
        horizontalLine5.anchor(top: weightTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Sex Label
        containerView.addSubview(sexTextField)
        sexTextField.anchor(top: horizontalLine5.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine6)
        horizontalLine6.anchor(top: sexTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        // Age Label
        containerView.addSubview(ageTextField)
        ageTextField.anchor(top: horizontalLine6.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine7)
        horizontalLine7.anchor(top: ageTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //Style label
        containerView.addSubview(styleTextField)
        styleTextField.anchor(top: horizontalLine7.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 7.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        containerView.addSubview(horizontalLine8)
        horizontalLine8.anchor(top: styleTextField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        //SignUp Button
        containerView.addSubview(signUpButton)
        signUpButton.anchor(top: horizontalLine8.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 280, height: 44)
        signUpButton.layer.cornerRadius = 22
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    // MARK: - SignUp && SignIn
    @objc func handleSignUp(){
        guard let email = eMailTextField.text else { return }
        guard let password = passwordSignUp.text else { return }
        let db = Firestore.firestore()
        let uuidDocument = UUID().uuidString
        
        let userData: [String: Any] = [
            "KişiselBilgiler": [
                "Ad": nameTextField.text,
                "Boy": heightTextField.text,
                "Cinsiyet": sexTextField.text,
                "Eposta": eMailTextField.text,
                "Kilo": weightTextField.text,
                "Şifre": passwordSignUp.text,
                "Tarz": styleTextField.text,
                "Yaş": ageTextField.text
            ],
            "Kombin": [
                "Adı": nameTextField.text,
                "Linki": nameTextField.text,
                "Saati": nameTextField.text,
                "StilistYorumu": nameTextField.text
            ]
        ]
        
        if email != "" && password != ""{
            
            Auth.auth().createUser(withEmail: email, password: password) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error ")
                }
                else {
                    db.collection("Kullanıcılar").document("\(Auth.auth().currentUser!.email!).\(uuidDocument)").setData(userData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        }
        else {
            makeAlert(titleInput: "Error", messageInput: "Username/Pasword is invalid")
        }
    }
    @objc func handleSignIn(){
        
        // properties
        guard
            let email = eMailTextFieldForSignIn.text,
            let password = passwordSignIn.text else { return }
        flag = "signedIn"
        if email != "" && password != ""{
            
            Auth.auth().signIn(withEmail: email, password: password) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: "Username/Pasword is invalid")
                } else {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Pasword is invalid")
        }
    }
}
