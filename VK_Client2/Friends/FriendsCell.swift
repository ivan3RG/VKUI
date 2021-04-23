//
//  FriendsCellTableViewCell.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
}
