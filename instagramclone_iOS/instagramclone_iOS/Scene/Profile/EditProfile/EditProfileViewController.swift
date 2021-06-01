//
//  EditProfileViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        closeBtn.addTarget(self, action: #selector(tappedCloseBtn), for: .touchUpInside)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        let alertC = UIAlertController(title: "", message: "정말로 로그아웃 하시겠습니까?", preferredStyle: .alert)
        let alertA = UIAlertAction(title: "확인", style: .default) { _ in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popViewController(animated: false)
                
            } catch let signOutError as NSError {
                let alertErrC = UIAlertController(title: "", message: "로그아웃에 실패하였습니다", preferredStyle: .alert)
                let alertErrA = UIAlertAction(title: "확인", style: .default, handler: nil)
                alertErrC.addAction(alertErrA)
                self.present(alertErrC, animated: true, completion: nil)
                print("SignOut Error: %@", signOutError)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alertC.addAction(alertA)
        alertC.addAction(cancel)
        self.present(alertC, animated: true, completion: nil)
        
    }
    
    @objc func tappedCloseBtn() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "fullNameCell", for: indexPath) as? EditProfileTableViewCell else { fatalError() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userNameCell", for: indexPath) as? EditProfileTableViewCell else { fatalError() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "bioCell", for: indexPath) as? EditProfileTableViewCell else { fatalError() }
            return cell
            
        default:
            fatalError()
        }
}
}
