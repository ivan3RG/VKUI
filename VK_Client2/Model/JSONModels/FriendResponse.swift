//
//  FriendResponse.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 01.02.2021.
//

import Foundation

class FriendsResponse: Decodable {
    var response: FriendsItems
}

class FriendsItems: Decodable {
    var items: [FriendsModel]
}

class FriendsModel: Decodable {
    var firstName: String
    var lastName: String
    var id: Int
    var photoUrl: String
    
    enum FriendsModel: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case photoUrl = "photo_100"
        case items
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FriendsModel.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.id = try container.decode(Int.self, forKey: .id)
        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
    }
}
