//
//  SignInViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/06/01.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        signUpButton.addTarget(self, action: #selector(tappedSignUpButoon), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
    }

    
    @objc func tappedSignUpButoon() {
        let sb = UIStoryboard(name: "SignUpViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { fatalError() }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedLoginButton() {
        guard let email = emailTextField.text else { fatalError() }
        guard let password = passwordTextField.text else { fatalError() }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if authResult?.user != nil {
                self?.dismiss(animated: true, completion: nil)
                } else {
                    let alertC = UIAlertController(title: "오류", message: "아이디 혹은 비밀번호를 확인해주세요", preferredStyle: .alert)
                    let alertA = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertC.addAction(alertA)
                    self?.present(alertC, animated: true, completion: nil)
                }
        }
    }
}
