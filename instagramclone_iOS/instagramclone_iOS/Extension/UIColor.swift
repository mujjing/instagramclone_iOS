//
//  UIColor.swift
//  instagramclone_iOS
//
//  Created by 전지훈 on 2021/06/01.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
