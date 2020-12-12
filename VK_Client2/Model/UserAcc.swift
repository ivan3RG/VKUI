//
//  File.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 19.10.2020.
//

import Foundation

class UserAcc {
   
    var friends: [String]
    var images: [String?]
    var accs: [(String, String?)]
  
    init(friends: [String]=[], images: [String?]=[], accs: [(String, String?)] = []){
        self.friends = friends
        self.images = images
        self.accs = accs
    }

    func addUserAcc(friend: String, image: String?) { //ToDo
        let acc = (friend, image)
        accs.append(acc)
    }

    func deleteUserAcc(friend: String) { //ToDo
        for i in 0...accs.count-1{
            if friend == accs[i].0{
                accs.remove(at: i)
            }
        }
    } //may be it state like this, may be not
    
    func converter(friends: [String], images: [String?]){
        for i in 0...friends.count - 1{
            let acc = (friends[i], images[i])
            accs.append(acc)
        } //to invent the wheel
    }
}
