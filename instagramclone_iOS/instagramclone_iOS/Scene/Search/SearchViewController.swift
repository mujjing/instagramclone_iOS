//
//  SearchViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var users: [User] = []
    var viewModel: SearchViewModel = SearchViewModel()
    
    let word : [String] = ["apple", "banana", "kiwi", "amp", "king"]
    var searchWord : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        self.users.removeAll()
        self.tableView.reloadData()
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (self.textField.text?.count) ?? 0 != 0 {
            self.users.removeAll()
            for str in viewModel.userData {
                let range = str.fullname.lowercased().range(of: textField.text ?? "", options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.users.append(str)
                }
            }
        } else {
            self.users.removeAll()
        }
        self.tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else { fatalError() }
        let user = users[indexPath.row]
        cell.searchUserData(data: user)
        cell.userUid = user.uid
        print("papapap \(user.uid)")
        cell.checkFollowingStatus(followingUid: user.uid)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


extension SearchViewController {
    private func getUserData() {
        
        let ref = Database.database().reference().child("Users").queryOrdered(byChild: "fullname")
        ref.observe(.value) { snapshot in
            self.viewModel.userData.removeAll()
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if let postData = snap.value as? [String:Any]{
                        guard let uid = postData["uid"] as? String else { return }
                        if Auth.auth().currentUser?.uid != uid {
                            guard let username = postData["username"] as? String else { return }
                            guard let fullname = postData["fullname"] as? String else { return }
                            guard let bio = postData["bio"] as? String else { return }
                            guard let image = postData["image"] as? String else { return }
                            
                            self.viewModel.userData.append(User(username: username, fullname: fullname , bio: bio, image: image, uid: uid))
                        }
                    }
                }
            }
        }
    }
}
