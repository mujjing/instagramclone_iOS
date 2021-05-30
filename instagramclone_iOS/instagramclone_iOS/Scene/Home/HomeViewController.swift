//
//  HomeViewController.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/05/31.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftBarIcon(named: "instagram")
        addRightBarIcon(named: "send")
    }
    
    @objc func gotSettingPage(){
        print("select send")
    }
    
    func addLeftBarIcon(named:String) {

       let logoImage = UIImage.init(named: named)
       let logoImageView = UIImageView.init(image: logoImage)
       logoImageView.frame = CGRect(x:0.0,y:0.0, width:90,height:45.0)
       logoImageView.contentMode = .scaleAspectFill
       let imageItem = UIBarButtonItem.init(customView: logoImageView)
       let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 90)
       let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 45)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem =  imageItem
   }
    
    func addRightBarIcon(named:String) {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: named), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.addTarget(self, action: #selector(gotSettingPage), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)

        self.navigationItem.rightBarButtonItem = barButton
   }

}
