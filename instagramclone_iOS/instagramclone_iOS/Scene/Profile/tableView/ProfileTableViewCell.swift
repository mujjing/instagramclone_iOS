//
//  ProfileTableViewCell.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    var delegate: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editProfileBtn.addTarget(self, action: #selector(tappedEditProfileBtn), for: .touchUpInside)
    }

    
    @objc func tappedEditProfileBtn() {
        let sb = UIStoryboard(name: "EditProfileViewController", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else { fatalError() }
        delegate?.navigationController?.pushViewController(vc, animated: true)
    }
}
