//
//  GroupResponse.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 01.02.2021.
//

import Foundation

class GroupResponse: Decodable {
    
    var response: GroupsItems
}

class GroupsItems: Decodable {
    
    var items: [GroupsModels]
}

class GroupsModels: Decodable {
    
    var id: Int
    var name: String
    var membership: Int
    var photoUrl: String
    
    enum GroupsCodingCeys: String, CodingKey {
        case id
        case name
        case membership = "is_member"
        case photoUrl = "photo_100"
        case items
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GroupsCodingCeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.membership = try container.decode(Int.self, forKey: .membership)
        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
    }
}
