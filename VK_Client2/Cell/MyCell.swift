//
//  MyCell.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 14.11.2020.
//

import UIKit

final class MyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myCell: UIView!
    
    @IBOutlet weak var ava: AvatarView!
    
    func configure(title: String, image: String, color: UIColor){
        titleLabel.text = title
        myCell.backgroundColor = color
        ava.avatar.image = UIImage(named: image)
    }
}
