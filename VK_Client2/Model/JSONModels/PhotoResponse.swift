//
//  PhotoResponse.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 01.02.2021.
//

import Foundation

class PhotoResponse: Decodable {
    
    var response: PhotoItems
}

class PhotoItems: Decodable {
    var items: [PhotoModels]
}

class PhotoModels: Decodable {
    var sizes: [Sizes]
    var likes: PhotoLike
}

class Sizes: Decodable {
    var url: String
    var type: String
    
    enum PhotoCodingKeys: String, CodingKey {
        case url
        case type
        case sizes
        case items
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoCodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

class PhotoLike: Decodable{
    var userLikes: Int
    var countLikes: Int
    
    enum PhotoLikesCodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case countLikes = "count"
        case likes
        case items
        case response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoLikesCodingKeys.self)
        self.userLikes = try container.decode(Int.self, forKey: .userLikes)
        self.countLikes = try container.decode(Int.self, forKey: .countLikes)
    }
}
