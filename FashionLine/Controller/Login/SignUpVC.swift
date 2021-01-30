//
//  SignUpVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 5.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit
import Firebase

import UIKit
import Firebase
class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    // MARK: - Properties
    
    var langFile = Localization.shared
    var imageSelected = false
    let pickerView = UIPickerView()
    let agePickerView = UIPickerView()
    let sexPickerView = UIPickerView()
    let weightPickerView = UIPickerView()
    let heightPickerView = UIPickerView()
    var yourStyleGuy: [String] = []
    var agePicker: [String] = []
    var sexPicker: [String] = []
    var weightPicker = [String]()
    var heightPicker = [String]()
    let plusPhotoBtn: UIButton = {
        let button = UIButton(type: .system)
        //        button.setImage(#imageLiteral(resourceName: "darkAddButton").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let passwordSignUp: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let sexTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let styleTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#FFD3D3")
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        //        self.emailTextField.delegate = self
        //        self.nameTextField.delegate = self
        //        self.passwordSignUp.delegate = self
        //        self.heightTextField.delegate = self
        //        self.weightTextField.delegate = self
        self.sexTextField.delegate = self
        self.ageTextField.delegate = self
        self.styleTextField.delegate = self
        
        // background color
        view.backgroundColor = .white
        
        configureViewComponents()
        createPickerView()
        dismissPickerView()
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.hideKeyboardWhenTappedAround()
        return true
    }
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }
    // MARK: - UIImagePickerController
    
    /// function that handles selecting image from camera roll
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // selected image
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        // set imageSelected to true
        imageSelected = true
        
        // configure plusPhotoBtn with selected image
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        plusPhotoBtn.layer.borderWidth = 2
        plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Handlers
    
    @objc func handleSelectProfilePhoto() {
        
        // configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // present image picker
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func handleShowLogin() {
        _ = navigationController?.popViewController(animated: true)
    }
    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }
    @objc func handleSignUp(){
        guard let emailLabel = emailTextField.text?.uppercased() else { return }
        guard let passwordLabel = passwordSignUp.text else { return }
        
        let db = Firestore.firestore()
        let uuidDocument = UUID().uuidString
        
        let userData: [String: Any] = [
            "KişiselBilgiler": [
                "Ad": nameTextField.text,
                "Boy": heightTextField.text,
                "Cinsiyet": sexTextField.text,
                "Eposta": emailTextField.text,
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
            ],
            "Request": "notRequested"
        ]
        
        if emailLabel != "" && passwordLabel != ""{
            
            Auth.auth().createUser(withEmail: emailLabel, password: passwordLabel) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error ")
                }
                else {
                    db.collection("Kullanıcılar").document("\(emailLabel)").setData(userData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.sendVerificationMail()
                        }
                    }
                    // Create the alert controller
                    let alertController = UIAlertController(title: self.langFile.format("SignUpVC", "check"), message: self.langFile.format("SignUpVC", "checkEmail"), preferredStyle: .alert)
                    
                    // Create the actions
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        self.handleShowLogin()
                    }
                    // Add the actions
                    alertController.addAction(okAction)

                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        }
        else {
            makeAlert(titleInput: self.langFile.format("SignUpVC", "error"), messageInput: self.langFile.format("SignUpVC", "usernamePassword"))
        }
    }
    @objc func formValidation() {
        
        guard
            emailTextField.hasText,
            passwordSignUp.hasText,
            nameTextField.hasText,
            heightTextField.hasText,
            weightTextField.hasText,
            sexTextField.hasText,
            ageTextField.hasText else {
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(hexString: "#FFD3D3")
                return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(hexString: "#E61515")
    }
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordSignUp, nameTextField, heightTextField, weightTextField, sexTextField, ageTextField, styleTextField, signUpButton])
        // Json decoding
        emailTextField.placeholder = langFile.format("SignUpVC", "email")
        passwordSignUp.placeholder = langFile.format("SignUpVC", "password")
        nameTextField.placeholder = langFile.format("SignUpVC", "nameSurname")
        heightTextField.placeholder = langFile.format("SignUpVC", "height")
        weightTextField.placeholder = langFile.format("SignUpVC", "weight")
        sexTextField.placeholder = langFile.format("SignUpVC", "sex")
        ageTextField.placeholder = langFile.format("SignUpVC", "age")
        styleTextField.placeholder = langFile.format("SignUpVC", "styleType")
        self.yourStyleGuy = [langFile.format("SignUpVC", "classic"), langFile.format("SignUpVC", "romantic"), langFile.format("SignUpVC", "elegant"), langFile.format("SignUpVC", "natural"), langFile.format("SignUpVC", "attractive"), langFile.format("SignUpVC", "dramatic"), langFile.format("SignUpVC", "creative"), langFile.format("SignUpVC", "minimalistic")]
        self.sexPicker = [langFile.format("SignUpVC", "female"),langFile.format("SignUpVC", "male"),langFile.format("SignUpVC", "identify")]
        for i in 0 ... 120 {
            weightPicker.append("\(i+30) kg")
        }
        for i in 0 ... 170 {
            heightPicker.append("\(i+50) cm")
        }
        for i in 0 ... 82 {
            agePicker.append("\(i+18)")
        }
        signUpButton.setTitle(langFile.format("SignUpVC", "signUp"), for: .normal)
        let attributedTitle = NSMutableAttributedString(string: langFile.format("SignUpVC", "alreadyHaveAnAccount"), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: langFile.format("SignUpVC", "signIn"), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        alreadyHaveAccountButton.setAttributedTitle(attributedTitle, for: .normal)
        
        // Stack view arrangements
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 150, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 400)
    }
    func createPickerView() {
        agePickerView.delegate = self
        heightPickerView.delegate = self
        weightPickerView.delegate = self
        sexPickerView.delegate = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        agePickerView.backgroundColor = .white
        heightPickerView.backgroundColor = .white
        weightPickerView.backgroundColor = .white
        sexPickerView.backgroundColor = .white
        pickerView.selectRow(2, inComponent: 0, animated: true)
        sexPickerView.selectRow(2, inComponent: 0, animated: true)
        weightPickerView.selectRow(20, inComponent: 0, animated: true)
        agePickerView.selectRow(3, inComponent: 0, animated: true)
        heightPickerView.selectRow(105, inComponent: 0, animated: true)
        heightTextField.inputView = heightPickerView
        weightTextField.inputView = weightPickerView
        styleTextField.inputView = pickerView
        sexTextField.inputView = sexPickerView
        ageTextField.inputView = agePickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: self.langFile.format("SignUpVC", "done"), style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        styleTextField.inputAccessoryView = toolBar
        sexTextField.inputAccessoryView = toolBar
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
        ageTextField.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
}
extension SignUpVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexPickerView{
            return sexPicker.count
        }else if pickerView == agePickerView{
            return agePicker.count
        }
        else if pickerView == heightPickerView{
            return heightPicker.count
        }else if pickerView == weightPickerView{
            return weightPicker.count
        }
        else{
        return yourStyleGuy.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sexPickerView{
            return sexPicker[row]
        }else if pickerView == agePickerView{
            return agePicker[row]
        }
        else if pickerView == heightPickerView{
            return heightPicker[row]
        }else if pickerView == weightPickerView{
            return weightPicker[row]
        }else {
        return yourStyleGuy[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sexPickerView{
            sexTextField.text = sexPicker[row]
        }else if pickerView == agePickerView{
            ageTextField.text = agePicker[row]
        }
        else if pickerView == heightPickerView{
            heightTextField.text = heightPicker[row]
        }else if pickerView == weightPickerView{
            weightTextField.text = weightPicker[row]
        }
        else{
        styleTextField.text = yourStyleGuy[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == sexPickerView{
          return NSAttributedString(string: sexPicker[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }else if pickerView == agePickerView{
          return NSAttributedString(string: agePicker[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        else if pickerView == heightPickerView{
          return NSAttributedString(string: heightPicker[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }else if pickerView == weightPickerView{
          return NSAttributedString(string: weightPicker[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        else{
        return NSAttributedString(string: yourStyleGuy[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
    }
}
