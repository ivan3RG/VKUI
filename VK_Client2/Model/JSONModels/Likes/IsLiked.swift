//
//  IsLiked.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 07.02.2021.
//

import Foundation

class IsLikedResponse: Decodable {
    var response: IsLiked
}

class IsLiked: Decodable {
    var liked: Int
    
    enum IsLikedCodingKeys: String, CodingKey {
        case liked
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IsLikedCodingKeys.self)
        self.liked = try container.decode(Int.self, forKey: .liked)
    }
}
