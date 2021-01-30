//
//  CombineDesignVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 12.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
import OneSignal
class CombineDesignVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    // MARK: - Properties
    var imageSelected1 = false
    var imageSelected2 = false
    var imageSelected3 = false
    var stringSelected: String?
    
    var shared = Admin.sharedInstance
    let plusPhotoBtn1: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusButton").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
    }()
    let plusPhotoBtn2: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusButton").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto2), for: .touchUpInside)
        return button
    }()
    let plusPhotoBtn3: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusButton").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto3), for: .touchUpInside)
        return button
    }()
    let nameOfProductTextField1: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ürünün Adı ve Fiyatı"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let nameOfProductTextField2: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ürünün Adı ve Fiyatı"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let nameOfProductTextField3: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ürünün Adı ve Fiyatı"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let linkOfProductTextField1: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Linki"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let linkOfProductTextField2: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Linki"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let linkOfProductTextField3: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Linki"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let stylerCommentTextField1: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Stilist yorumu"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let stylerCommentTextField2: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Stilist yorumu"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let stylerCommentTextField3: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Stilist yorumu"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()
        nameOfProductTextField3.delegate = self
        linkOfProductTextField3.delegate = self
        stylerCommentTextField3.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kombinleri Gönder", style: .plain, target: self, action: #selector(handleSendCombine))
        
        configureViewComponents()
    }
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.hideKeyboardWhenTappedAround()
        return true
    }
    // MARK: - UIImagePickerController
    
    /// function that handles selecting image from camera roll
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // selected image
        guard let profileImage1 = info[.editedImage] as? UIImage else {
            imageSelected1 = false
            return
        }
        guard let profileImage2 = info[.editedImage] as? UIImage else {
            imageSelected2 = false
            return
        }
        guard let profileImage3 = info[.editedImage] as? UIImage else {
                   imageSelected3 = false
                   return
        }
        
        
        if stringSelected == "1selected" {
            // configure plusPhotoBtn with selected image
            plusPhotoBtn1.layer.cornerRadius = plusPhotoBtn1.frame.width / 8
            plusPhotoBtn1.layer.masksToBounds = true
            plusPhotoBtn1.layer.borderColor = UIColor.black.cgColor
            plusPhotoBtn1.layer.borderWidth = 2
            plusPhotoBtn1.setImage(profileImage1.withRenderingMode(.alwaysOriginal), for: .normal)
            self.dismiss(animated: true, completion: nil)
            // set imageSelected to true
            imageSelected1 = true
        }
        else if stringSelected == "2selected" {
            plusPhotoBtn2.layer.cornerRadius = plusPhotoBtn2.frame.width / 8
            plusPhotoBtn2.layer.masksToBounds = true
            plusPhotoBtn2.layer.borderColor = UIColor.black.cgColor
            plusPhotoBtn2.layer.borderWidth = 2
            plusPhotoBtn2.setImage(profileImage2.withRenderingMode(.alwaysOriginal), for: .normal)
            self.dismiss(animated: true, completion: nil)
            // set imageSelected to true
            imageSelected2 = true
        }
        else if stringSelected == "3selected" {
            plusPhotoBtn3.layer.cornerRadius = plusPhotoBtn2.frame.width / 8
            plusPhotoBtn3.layer.masksToBounds = true
            plusPhotoBtn3.layer.borderColor = UIColor.black.cgColor
            plusPhotoBtn3.layer.borderWidth = 2
            plusPhotoBtn3.setImage(profileImage3.withRenderingMode(.alwaysOriginal), for: .normal)
            self.dismiss(animated: true, completion: nil)
            // set imageSelected to true
            imageSelected3 = true
        }
        else {
            print("not selected")
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    // MARK: - Handlers
    
    @objc func handleSelectProfilePhoto() {
        
        // configure image picker
        let imagePicker1 = UIImagePickerController()
        imagePicker1.delegate = self
        imagePicker1.allowsEditing = true
        
        // present image picker
        self.present(imagePicker1, animated: true, completion: nil)
        stringSelected = "1selected"
    }
    @objc func handleSelectProfilePhoto2() {
        
        // configure image picker
        let imagePicker2 = UIImagePickerController()
        imagePicker2.delegate = self
        imagePicker2.allowsEditing = true
        
        // present image picker
        self.present(imagePicker2, animated: true, completion: nil)
        stringSelected = "2selected"
    }
    @objc func handleSelectProfilePhoto3() {
        
        // configure image picker
        let imagePicker3 = UIImagePickerController()
        imagePicker3.delegate = self
        imagePicker3.allowsEditing = true
        
        // present image picker
        self.present(imagePicker3, animated: true, completion: nil)
        stringSelected = "3selected"
    }
    @objc func formValidation() {
        
        guard
            nameOfProductTextField1.hasText,
            linkOfProductTextField1.hasText,
            stylerCommentTextField1.hasText,
            nameOfProductTextField2.hasText,
            linkOfProductTextField2.hasText,
            stylerCommentTextField2.hasText,
            nameOfProductTextField3.hasText,
            linkOfProductTextField3.hasText,
            stylerCommentTextField3.hasText,
            imageSelected1 == true && imageSelected2 == true && imageSelected3 == true else {
                navigationItem.rightBarButtonItem?.isEnabled = false
                return
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    func configureViewComponents() {
        
        let stackView1 = UIStackView(arrangedSubviews: [nameOfProductTextField1, linkOfProductTextField1, stylerCommentTextField1])
        let stackView2 = UIStackView(arrangedSubviews: [nameOfProductTextField2, linkOfProductTextField2, stylerCommentTextField2])
        let stackView3 = UIStackView(arrangedSubviews: [nameOfProductTextField3, linkOfProductTextField3, stylerCommentTextField3])
        
        stackView1.axis = .vertical
        stackView1.spacing = 10
        stackView1.distribution = .fillEqually
        
        stackView2.axis = .vertical
        stackView2.spacing = 10
        stackView2.distribution = .fillEqually
        
        stackView3.axis = .vertical
        stackView3.spacing = 10
        stackView3.distribution = .fillEqually
        
        view.addSubview(plusPhotoBtn1)
        plusPhotoBtn1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 75, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        view.addSubview(plusPhotoBtn2)
        plusPhotoBtn2.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 75, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 140, height: 140)
        
        
        view.addSubview(stackView1)
        stackView1.anchor(top: plusPhotoBtn1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 150, height: 100)
        
        view.addSubview(stackView2)
        stackView2.anchor(top: plusPhotoBtn2.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 150, height: 100)
        
        view.addSubview(plusPhotoBtn3)
        plusPhotoBtn3.anchor(top: stackView1.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoBtn3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(stackView3)
        stackView3.anchor(top: plusPhotoBtn3.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 100)
        stackView3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    // Push Notification
    func pushNotification(){
        guard let userEmail = self.shared.email?.lowercased() else { return }
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("PlayerId").whereField("email", isEqualTo: userEmail).getDocuments { (snapshot, error) in
            if error == nil {
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        
                        if let playerId = document.get("player_id") as? String {
                            
                            //PUSH NOTIFICATION
                            
                            //                            OneSignal.postNotification(["contents": ["en":"liked your post "], "include_player_ids": ["\(playerId)"]])
                            OneSignal.postNotification(["contents": ["en": "Yeni kombinin geldi!"], "include_player_ids": [playerId]])
                        }
                    }
                }
            }
        }
        
    }
    @objc func handleSendCombine() {
        print("Clicked")
        
        guard let nameOfProduct1 = nameOfProductTextField1.text else { return }
        guard let nameOfProduct2 = nameOfProductTextField2.text else { return }
        guard let nameOfProduct3 = nameOfProductTextField3.text else { return }
        guard let linkOfProduct1 = linkOfProductTextField1.text else { return }
        guard let linkOfProduct2 = linkOfProductTextField2.text else { return }
        guard let linkOfProduct3 = linkOfProductTextField3.text else { return }
        guard let stylerComment1 = stylerCommentTextField1.text else { return }
        guard let stylerComment2 = stylerCommentTextField2.text else { return }
        guard let stylerComment3 = stylerCommentTextField3.text else { return }
        
        let userData: [String: Any] =  [ "Combines": [
        "1.kombin": [
        "Ad": nameOfProduct1,
        "Linki": linkOfProduct1,
        "StilistYorumu": stylerComment1
        ],
        "2.kombin": [
        "Ad": nameOfProduct2,
        "Linki": linkOfProduct2,
        "StilistYorumu": stylerComment2
        ],
        "3.kombin": [
        "Ad": nameOfProduct3,
        "Linki": linkOfProduct3,
        "StilistYorumu": stylerComment3
        ],
        ],
        "Request": "requested"
        ]
       
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        let uuidImage1 = UUID().uuidString
        let uuidImage2 = UUID().uuidString
        let uuidImage3 = UUID().uuidString
    
        guard let profileImg1 = self.plusPhotoBtn1.imageView?.image else { return }
        guard let uploadData1 = profileImg1.jpegData(compressionQuality: 0.3) else { return }
        let imageReference1 = mediaFolder.child("\(uuidImage1).jpg")
        
        guard let profileImg2 = self.plusPhotoBtn2.imageView?.image else { return }
        guard let uploadData2 = profileImg2.jpegData(compressionQuality: 0.3) else { return }
        let imageReference2 = mediaFolder.child("\(uuidImage2).jpg")
        
        guard let profileImg3 = self.plusPhotoBtn3.imageView?.image else { return }
        guard let uploadData3 = profileImg3.jpegData(compressionQuality: 0.3) else { return }
        let imageReference3 = mediaFolder.child("\(uuidImage3).jpg")
        
            imageReference1.putData(uploadData1, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    imageReference1.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl1 = url?.absoluteString
                            
                            //ADD DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            firestoreDatabase.collection( "Kullanıcılar").document(self.shared.email?.uppercased() ?? "").setData([ "Combines": [
                            "1.kombin": [
                            "Saati": imageUrl1,
                            ],
                            ],
                            ], merge: true)
                            { err in
                                if err != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    print("Document successfully written!")
                                    
                                }
                            }
                            
                        }
                    }
                }
        }
        imageReference2.putData(uploadData2, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    imageReference2.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl2 = url?.absoluteString
                          
                            //ADD DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            firestoreDatabase.collection( "Kullanıcılar").document(self.shared.email?.uppercased() ?? "").setData([ "Combines": [
                            "2.kombin": [
                            "Saati": imageUrl2,
                            ],
                            ],
                            ], merge: true)
                            { err in
                                if err != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    print("Document successfully written!")
                                    
                                }
                            }
                            
                        }
                    }
            }
        }
        imageReference3.putData(uploadData3, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    imageReference3.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl3 = url?.absoluteString
                            
                            //ADD DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            firestoreDatabase.collection( "Kullanıcılar").document(self.shared.email?.uppercased() ?? "").setData([ "Combines": [
                            "3.kombin": [
                            "Saati": imageUrl3,
                            ],
                            ],
                            ], merge: true)
                            { err in
                                if err != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    print("Document successfully written!")
                                    
                                }
                            }
                            
                        }
                    }
                }
        }
        let db = Firestore.firestore()
       if nameOfProduct1 != "" && linkOfProduct1 != "" && stylerComment1 != "" && imageSelected1 == true && nameOfProduct2 != "" && linkOfProduct2 != "" && stylerComment2 != "" && imageSelected2 == true && nameOfProduct3 != "" && linkOfProduct3 != "" && stylerComment3 != "" && imageSelected3 == true{
            
            db.collection("Kullanıcılar").document(self.shared.email?.uppercased() ?? "").setData(userData, merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.pushNotification()
                }
            }
            _ = self.navigationController?.popViewController(animated: true)
            _ = self.navigationController?.popViewController(animated: true)
        
        }
        else {
            makeAlert(titleInput: "Hata", messageInput: "Tüm bilgileri doldurmalısın :)")
        }
    }
}
