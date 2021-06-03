//
//  SearchTableViewCell.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/06/02.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageVew: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: UIViewController?
    var viewModel: SearchViewModel = SearchViewModel()
    var userUid: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.addTarget(self, action: #selector(tappedFollowButton), for: .touchUpInside)
        profileImageVew.layer.cornerRadius = profileImageVew.frame.height / 2
    }
    
    func searchUserData(data: User) {
        DispatchQueue.main.async {
            guard let url = URL(string: data.image) else { return }
            let image = try! Data(contentsOf: url)
            
            self.profileImageVew.image = UIImage(data: image)
        }
        usernameLabel.text = data.username
        fullnameLabel.text = data.fullname
    }
    
    func searchString(data: String) {
        usernameLabel.text = data
        fullnameLabel.text = data
    }

    @objc func tappedFollowButton() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference()
        ref.child("Follow").child(uid).child("Following").queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in

            if self.followButton.titleLabel?.text == "Follow" {
                let following = ["Following/\(self.userUid ?? "")" : true]
                let followers = ["Followers/\(uid)" : true]
                
                ref.child("Follow").child(uid).updateChildValues(following)
                ref.child("Follow").child(self.userUid ?? "").updateChildValues(followers)
                self.followButton.setTitle("Following", for: .normal)
                
            } else {
                
                ref.child("Follow").child(uid).child("Following/\(self.userUid ?? "")").removeValue()
                ref.child("Follow").child(self.self.userUid ?? "").child("Followers/\(uid)").removeValue()
                self.followButton.setTitle("Follow", for: .normal)
            }
        }
        ref.removeAllObservers()
    }
    
    func checkFollowingStatus(followingUid: String) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let ref = Database.database().reference()
//        ref.child("Follow").child(uid).child("Following").queryOrderedByKey().observe(.value) { snapshot in
//            if let following = snapshot.value as? [String : Any] {
//                for (key, _) in following {
//                    print("key: \(key) uid \(followingUid) ")
//                    if key == followingUid {
//                        self.followButton.setTitle("Following", for: .normal)
//                    } else {
//                        self.followButton.setTitle("Follow", for: .normal)
//                    }
//                }
//            }
//        }
        //ref.removeAllObservers()
    }
}
 
