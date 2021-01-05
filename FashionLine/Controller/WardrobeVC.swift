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
        pp.setTitle("Güncelle", for: .normal)
        pp.titleLabel?.font = UIFont.init(name: "SFProText-Regular", size: 17)
        pp.setTitleColor(UIColor(hexString: "#E61515"), for: UIControl.State.normal)
        pp.layer.borderColor = UIColor(hexString: "#707070").cgColor
        pp.layer.borderWidth = 1
        pp.backgroundColor = UIColor(hexString: "#FFFFFF")
        return pp
    }()
    let signInButton: UIButton = {
        let pp = UIButton(type: .system)
        pp.setTitle("Sil", for: .normal)
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
        rn.text = "Oylamaya sunduğunuz kombininiz 24 saat sonra otomatik olarak silinir"
        rn.font = UIFont.init(name: "SFProDisplay-RegularItalic", size: 15)
        rn.textColor = UIColor(hexString: "#707070")
        return rn
    }()
    let userNameLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Ashley"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-MediumItalic-SemiBold", size: 14)
        tf.textColor = UIColor(hexString: "#000000")
        return tf
    }()
    let conceptLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Bir akşam yemeğine davetliyim. 3 Kız bu yemeğe gidiyoruz."
        tf.numberOfLines = 0
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 14)
        tf.textColor = UIColor(hexString: "#707070")
        return tf
    }()
    let pointLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Puanın: 8.8"
        tf.numberOfLines = 1
        tf.font = UIFont.init(name: "SFProText-Bold", size: 14)
        tf.textColor = UIColor(hexString: "#000000")
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
        rn.text = "Yorumlardaki Güncel Kombinim"
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 34)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let getMembershipNow: UILabel = {
        let rn = UILabel()
        rn.numberOfLines = 0
        rn.text = "Kişisel Bilgilerim"
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
    lazy var profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 22.5
        iv.clipsToBounds = true
        
        return iv
    }()
    let profilePicture: UIButton = {
        let pp = UIButton(type: .system)
        pp.setImage(UIImage(named: "profilePicture")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return pp
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
        // Logout label
        containerView.addSubview(profilePicture)
        profilePicture.anchor(top: nil, left: nil, bottom: horizontalLine1.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 9.5, paddingRight: 24, width: 30, height: 30)
        profilePicture.layer.cornerRadius = 15
        profilePicture.addTarget(self, action: #selector(handleLogutTapped), for: .touchUpInside)
        // Welcome Label
        containerView.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 130, paddingLeft: 15, paddingBottom: 0, paddingRight: 77.5, width: 0, height: 0)
        // Quick Label
        containerView.addSubview(quickLabel)
        quickLabel.anchor(top: welcomeLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 105, width: 0, height: 0)
        // Profile Image View
        containerView.addSubview(profileImageView)
        profileImageView.anchor(top: quickLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 26, paddingBottom: 0, paddingRight: 0, width: 45, height: 45)
        // Name & Concept & Point
        containerView.addSubview(userNameLabel)
        userNameLabel.anchor(top: quickLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 12, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
        //        containerView.addSubview(horizontalLine9)
        //        horizontalLine9.anchor(top: userNameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        containerView.addSubview(conceptLabel)
        conceptLabel.anchor(top: userNameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2, paddingLeft: 12, paddingBottom: 0, paddingRight: 37, width: 217, height: 39)
        containerView.addSubview(pointLabel)
        pointLabel.anchor(top: conceptLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 83, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //        containerView.addSubview(horizontalLine10)
        //        horizontalLine10.anchor(top: conceptLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 2.5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 1)
        
        // SignIn Button
        containerView.addSubview(signInButton)
        signInButton.anchor(top: pointLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 18.5, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 185, height: 28)
        signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        signInButton.layer.cornerRadius = 14
        signInButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        // Get membership now
        containerView.addSubview(getMembershipNow)
        getMembershipNow.anchor(top: signInButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 40, paddingLeft: 38, paddingBottom: 0, paddingRight: 54, width: 0, height: 0)
        // Name Label
        containerView.addSubview(nameTextField)
        nameTextField.anchor(top: getMembershipNow.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 55.5, paddingBottom: 0, paddingRight: 99.5, width: 0, height: 0)
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
        signUpButton.anchor(top: horizontalLine8.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 185, height: 28)
        signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        signUpButton.layer.cornerRadius = 14
        signUpButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
    }
    // MARK: - Handle Operations
    @objc func handleLogutTapped(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
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
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
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
            "Request": "notRequested"
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
            makeAlert(titleInput: "Hata", messageInput: "Tüm bilgileri doldurmalısın :)")
        }
    }
    @objc func deleteTapped(){
        
        // Remove
        
    }
}
