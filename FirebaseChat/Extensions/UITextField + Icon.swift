//
//  UITextField + Icon.swift
//  FirebaseChat
//
//  Created by TolBA on 21/01/23.
//  Copyright © 2023 TolBA. All rights reserved.
//

import UIKit

extension UITextField{
    func setImageLeftView(img: String){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let leftmailTFimg = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            leftmailTFimg.image = UIImage(named: img)
        view.addSubview(leftmailTFimg)
        leftView = view
        leftViewMode = .unlessEditing
    }
}
