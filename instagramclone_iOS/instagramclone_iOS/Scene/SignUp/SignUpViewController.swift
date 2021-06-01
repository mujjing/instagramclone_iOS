//
//  SignUpViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/06/01.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        signInButton.addTarget(self, action: #selector(tappedSignInButton), for: .touchUpInside)
        
        fullNameTF.delegate = self
        userNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        registerButton.isEnabled = false
        registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
        registerButton.setTitleColor(.lightGray, for: .normal)
        
        registerButton.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)

    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedSignInButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedRegisterButton() {
        
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Auth정보 저장에 실패하였습니다 \(err)")
                return
            } else {
                let alertController = UIAlertController(title: "", message: "회원가입에 성공 하였습니다", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "확인", style: .default) {_ in
                    guard let uid = res?.user.uid else {return}
                    guard let username = self.userNameTF.text else {return}
                    guard let fullname = self.fullNameTF.text else {return}
                    
                    let docData = [
                        "uid" : uid,
                        "fullname" : fullname,
                        "username": username,
                        "email": email,
                        "bio": "this is an instagram clone app",
                        "image": "https://firebasestorage.googleapis.com/v0/b/instagramapp-c04e1.appspot.com/o/Defaults%20Images%2Fprofile.jpeg?alt=media&token=f217e5a6-2f1c-4f26-b9b4-2304b7c3eb5d"
                    ] as [String : Any]
                    
                    Database.database().reference().child("Users").child(uid).setValue(docData) {
                        err, arg  in
                        if let err = err {
                            print("유저 정보를 DB에 저장하는데 실패하였습니다 \(err)")
                            return
                        }
                        print("유저 정보를 DB에 저장하였습니다 \(arg)")
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            print("Auth정보 저장에 성공하였습니다")
        }
    }
}


extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let emailIsEmpty = emailTF.text?.isEmpty ?? false
        let passwordIsEmpty = passwordTF.text?.isEmpty ?? false
        let usernameIsEmpty = userNameTF.text?.isEmpty ?? false
        let fullnameIsEmpty = fullNameTF.text?.isEmpty ?? false
        
        if emailIsEmpty || passwordIsEmpty || usernameIsEmpty || fullnameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 100, green: 100, blue: 100)
            registerButton.setTitleColor(.lightGray, for: .normal)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .white
            registerButton.setTitleColor(.black, for: .normal)
        }
    }
}
