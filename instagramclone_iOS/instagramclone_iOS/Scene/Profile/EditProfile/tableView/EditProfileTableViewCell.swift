//
//  EditProfileTableViewCell.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
