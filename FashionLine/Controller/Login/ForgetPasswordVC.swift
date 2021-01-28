//
//  ForgetPasswordVC.swift
//  FashionLine
//
//  Created by Furkan Y. on 28.01.2021.
//  Copyright © 2021 Furkan Y. All rights reserved.
//

import UIKit
import Firebase
class ForgetPasswordVC: UIViewController {
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-Posta"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Şifremi sıfırla", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#FFD3D3", alpha: 1)
        button.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
        button.isEnabled = false
        button.layer.cornerRadius = 5
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureViewComponents()
    }
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, forgetPasswordButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 70)
    }
    @objc func formValidation() {
        
        // ensures that email and password text fields have text
        guard
            emailTextField.hasText else {
                
                // handle case for above conditions not met
                forgetPasswordButton.isEnabled = false
                forgetPasswordButton.backgroundColor = UIColor(hexString: "#FFD3D3", alpha: 1)
                return
        }
        
        // handle case for conditions were met
        forgetPasswordButton.isEnabled = true
        forgetPasswordButton.backgroundColor = UIColor(hexString: "#E61515", alpha: 1)
    }
    @objc func handleForgetPassword(){
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            DispatchQueue.main.async {
                if self.emailTextField.text?.isEmpty==true || error != nil {
                    let resetFailedAlert = UIAlertController(title: "Şifre sıfırlama gerçekleşemedi", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                if error == nil && self.emailTextField.text?.isEmpty==false{
                    let resetEmailAlertSent = UIAlertController(title: "Şifre sıfırlama E-postası gönderildi", message: "Lütfen gönderilen E-posta daki linke tıklayarak talimatları gerçekleştriniz", preferredStyle: .alert)
                    resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailAlertSent, animated: true, completion: nil)
                }
            }
        }
    }
}
