//
//  UsersCellTVTableViewCell.swift
//  TChat
//
//  Created by TolBA on 12/13/19.
//  Copyright © 2019 TolBA. All rights reserved.
//

import UIKit
import SDWebImage

class UsersTVCell: UITableViewCell {
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
}

extension UsersTVCell {
    func configCell(user: User) {
        nameLabel.text = user.name
        userAvatar.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userAvatar.sd_setImage(with: URL(string: user.avatar), placeholderImage: UIImage(systemName: Images.placeholder))
    }
}
