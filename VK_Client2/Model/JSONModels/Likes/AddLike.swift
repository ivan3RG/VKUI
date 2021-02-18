//
//  AddLike.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 17.02.2021.
//

import Foundation

class AddLikeResponse: Decodable {
    var response: AddLike
}

class AddLike: Decodable {
    var likes: Int
    
    enum AddLikeCodingKeys: String, CodingKey {
        case likes
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AddLikeCodingKeys.self)
        self.likes = try container.decode(Int.self, forKey: .likes)
    }
}

