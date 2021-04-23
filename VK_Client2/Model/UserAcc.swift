//
//  File.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import Foundation
import SwiftUI

class UserAcc {
   
    var friends: [String]
    var imagesUrls: [String?]
    var images: [UIImage?]
    var friendsId: [Int?]
    var accs: [(String, String?, UIImage?, Int?)]
  
    init(friends: [String]=[], imagesUrls: [String?]=[], images: [UIImage?]=[], friendsId: [Int]=[], accs: [(String, String?, UIImage?, Int?)] = []){
        self.friends = friends
        self.imagesUrls = imagesUrls
        self.images = images
        self.friendsId = friendsId
        self.accs = accs
    }

    func addUserAcc(friend: String, imagesUrls: String?, images: UIImage?, friendsId: Int?) { //ToDo
        let acc = (friend, imagesUrls, images, friendsId)
        accs.append(acc)
    }

    func deleteUserAcc(friend: String) { //ToDo
        for i in 0...accs.count-1{
            if friend == accs[i].0{
                accs.remove(at: i)
            }
        }
    } //may be it state like this, may be not
    
    func converter(friends: [String], imagesUrls: [String?], images: [UIImage?], friendsId: [Int?]){
        for i in 0...friends.count - 1{
            let acc = (friends[i], imagesUrls[i], images[i], friendsId[i])
            accs.append(acc)
        } //to invent the wheel
    }
}
