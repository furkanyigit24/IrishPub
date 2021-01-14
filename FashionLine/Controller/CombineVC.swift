//
//  CombineVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 8.06.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import UIKit
import Firebase

class CombineVC: UIViewController {
    
    var userName: String = ""
    
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
        rn.font = UIFont.init(name: "SFProDisplay-Regular", size: 34)
        rn.textColor = UIColor(hexString: "#000000")
        return rn
    }()
    let toWhereTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nereye Gideceksin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let timeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Saat kaçta gideceksin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let combineTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nasıl bir kombin istersin?"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.0)
        tf.font = UIFont.init(name: "SFProText-Regular", size: 20)
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    let noteTextField: UITextField = {
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
    override func viewWillAppear(_ animated: Bool) {
        snapshotListener()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        snapshotListener()
        signUpButton.addTarget(self, action: #selector(sendCombine), for: .touchUpInside)
    }
    func snapshotListener(){
        let db = Firestore.firestore()
        guard var currentEmail = Auth.auth().currentUser?.email?.uppercased() as? String else{ return }
        db.collection("Kullanıcılar").document(currentEmail)
            .addSnapshotListener { documentSnapshot, error in
                
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("XXX \(data)")
                guard let newDictionary = data as? [String:Any] else { return }
                for (key,value) in newDictionary {
                    if key == "Request" {
                        guard let val = value as? String else { return }
                        switch val {
                        case "requested":
                            self.notSentViews()
                        case "notRequested":
                            self.notSentViews()
                        case "pendingRequest":
                            self.sentView()
                        default:
                            self.notSentViews()
                            print("Default")
                        }
                    }
                    if key == "KişiselBilgiler" {
                        guard let stringKey = value as? [String:String] else { return }
                        for (key,value) in stringKey {
                            guard let name = key as? String else { return }
                            switch name {
                            case "Ad":
                                print(value)
                                self.userName = value
                            default:
                                print("Default")
                            }
                        }
                    }
                }
                self.reloadInputViews()
        }
    }
    // MARK: - Set Up Views
    fileprivate func notSentViews() {
        signedUpMainMessage.removeFromSuperview()
        signedUpSubMessage.removeFromSuperview()
        // FashionLine Name Label
        view.addSubview(fashionLineNameLabel)
        fashionLineNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 82, paddingLeft: 25, paddingBottom: 0, paddingRight: 157, width: 0, height: 0)
        view.addSubview(horizontalLine1)
        horizontalLine1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 126.5, paddingLeft: 23.5, paddingBottom: 0, paddingRight: 23.5, width: 0, height: 1)
        // Welcome Label
        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 149, paddingLeft: 25, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        welcomeLabel.text = "Merhaba \(userName)"
        // Email Label
        view.addSubview(toWhereTextField)
        toWhereTextField.anchor(top: welcomeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine2)
        horizontalLine2.anchor(top: toWhereTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Name Label
        view.addSubview(timeTextField)
        timeTextField.anchor(top: horizontalLine2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine3)
        horizontalLine3.anchor(top: timeTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Height Label
        view.addSubview(combineTextField)
        combineTextField.anchor(top: horizontalLine3.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine4)
        horizontalLine4.anchor(top: combineTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        // Weight label
        view.addSubview(noteTextField)
        noteTextField.anchor(top: horizontalLine4.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 27, paddingLeft: 1, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.addSubview(horizontalLine5)
        horizontalLine5.anchor(top: noteTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2.5, paddingLeft: 1, paddingBottom: 0, paddingRight: 1, width: 0, height: 1)
        //SignUp Button
        view.addSubview(signUpButton)
        signUpButton.anchor(top: horizontalLine5.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 38, paddingBottom: 0, paddingRight: 57, width: 280, height: 44)
        signUpButton.layer.cornerRadius = 22
    }
    fileprivate func sentView() {
        // Navigation Contoller
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        signUpButton.removeFromSuperview()
        horizontalLine5.removeFromSuperview()
        noteTextField.removeFromSuperview()
        horizontalLine4.removeFromSuperview()
        combineTextField.removeFromSuperview()
        horizontalLine3.removeFromSuperview()
        welcomeLabel.removeFromSuperview()
        toWhereTextField.removeFromSuperview()
        horizontalLine2.removeFromSuperview()
        timeTextField.removeFromSuperview()
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
    
    @objc func sendCombine(){
        guard let toWhereLabel = toWhereTextField.text else { return }
        guard let timeLabel = timeTextField.text else { return }
        guard let combineLabel = combineTextField.text else { return }
        guard let noteLabel = noteTextField.text else { return }
        
        let db = Firestore.firestore()
        let uuidDocument = UUID().uuidString
        
        let userData: [String: Any] =  [
        "Kombin": [
        "Adı": toWhereLabel,
        "Linki": timeLabel,
        "Saati": combineLabel,
        "StilistYorumu": noteLabel
        ],
        "Request": "pendingRequest"
        ]
        if toWhereLabel != "" && timeLabel != "" && combineLabel != "" && noteLabel != ""{
            
            db.collection("Kullanıcılar").document("\(Auth.auth().currentUser!.email!.uppercased())").setData(userData, merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            _ = self.navigationController?.popViewController(animated: true)
            toWhereTextField.text = ""
            timeTextField.text = ""
            combineTextField.text = ""
            noteTextField.text = ""
        }
        else {
            makeAlert(titleInput: "Hata", messageInput: "Tüm bilgileri doldurmalısın :)")
        }
    }
}
