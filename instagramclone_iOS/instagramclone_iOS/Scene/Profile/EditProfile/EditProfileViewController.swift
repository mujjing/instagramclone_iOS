//
//  EditProfileViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        closeBtn.addTarget(self, action: #selector(tappedCloseBtn), for: .touchUpInside)
    }
    
    @objc func tappedCloseBtn() {
        dismiss(animated: true, completion: nil)
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
