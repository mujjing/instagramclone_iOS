//
//  ProfileViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "username"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated(){
        //Check auth status
        if Auth.auth().currentUser == nil{
            //show log in
        self.tabBarController?.selectedIndex = 0
        let sb = UIStoryboard(name: "SignInViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { fatalError() }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false, completion: nil)
        }
    }

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProfileTableViewCell else { fatalError() }
        cell.delegate = self
        return cell
    }
    
}
