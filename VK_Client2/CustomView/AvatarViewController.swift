//
//  AvatarViewController.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 21.10.2020.
//

import UIKit

class AvatarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let avatar = AvatarView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(avatar)
    }
}
