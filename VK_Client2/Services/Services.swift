//
//  Services.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 09.12.2020.
//

import Foundation
import Alamofire

let session = Session.instance

class Services {
    
    func communication(methodName: String, userId: String?, token: String?, v: String?, q: String?) -> URLComponents{
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
        switch methodName{
        case "friends":
            urlComponents.path = "/method/friends.get"
        case "photos":
            urlComponents.path = "/method/photos.get"
        case "groups":
            urlComponents.path = "/method/groups.get"
        case "groupsSearch":
            urlComponents.path = "/method/groups.search"
        case "isLiked":
            urlComponents.path = "/method/likes.isLiked"
        case "addLike":
            urlComponents.path = "/method/likes.add"
        default:
            return urlComponents
        }
        urlComponents.queryItems = [
            //URLQueryItem(name: "user_ids", value: userId),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: v)]
        switch  methodName {
        case "friends":
            urlComponents.queryItems?.append(URLQueryItem(name: "fields", value: "nickname,photo_100"))
        case "photos":
            urlComponents.queryItems?.append(URLQueryItem(name: "owner_id", value: userId))
            urlComponents.queryItems?.append(URLQueryItem(name: "album_id", value: "profile"))
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case "groups":
            urlComponents.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case "groupsSearch":
            urlComponents.queryItems?.append(URLQueryItem(name: "v", value: v))
            urlComponents.queryItems?.append(URLQueryItem(name: "q", value: q))
        case "isLiked":
            urlComponents.queryItems?.append(URLQueryItem(name: "owner_id", value: userId))
            urlComponents.queryItems?.append(URLQueryItem(name: "item_id", value: q))
        case "addLike":
            urlComponents.queryItems?.append(URLQueryItem(name: "owner_id", value: userId))
            urlComponents.queryItems?.append(URLQueryItem(name: "item_id", value: q))
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "photo"))
        default:
            return urlComponents
        }
        return urlComponents
    }
    
    func friendsList(userId: String?, token: String?, v: String?, completition: @escaping([FriendsModel]) -> Void){
        let urlComponents = communication(methodName: "friends", userId: userId.self, token: token.self, v: v.self, q: nil)
        guard let url = urlComponents.url else {return}
        
            AF.request(url).responseData{ (response) in
                guard let data = response.data else {return}
                do {
                    let responseFriends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                    let items = responseFriends.response.items
                    completition(items)
                } catch {
                    completition([])
                }
            }
            
    }
    
    func photos(userId: String?, token: String?, v: String?, completition: @escaping([PhotoModels]) -> Void){
        let urlComponents = communication(methodName: "photos", userId: userId.self, token: token.self, v: v.self, q: nil)
        guard let url = urlComponents.url else {return}
        
        AF.request(url).responseData{ (response) in
            guard let data = response.data else {return}
            do {
                let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
                let items = photoResponse.response.items
                print(items)
                completition(items)
            } catch {
                completition([])
            }
        }
    }
    
    func groups(userId: String?, token: String?, v: String?, completition: @escaping([GroupsModels]) -> Void){
        let urlComponents = communication(methodName: "groups", userId: userId.self, token: token.self, v: v.self, q: nil)
        guard let url = urlComponents.url else {return}
        AF.request(url).responseData{ (response) in
            guard let data = response.data else {return}
            do {
                let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                let items = groupsResponse.response.items
                print(items)
                completition(items)
            } catch {
                completition([])
            }
        }
    }
    
    func groupsSearch(userId: String?, token: String?, v: String?, q: String?, completition: @escaping([GroupsModels]) -> Void){
        let urlComponents = communication(methodName: "groupsSearch", userId: userId.self, token: token.self, v: v.self, q: q.self)
        guard let url = urlComponents.url else {return}
        AF.request(url).responseData{ (response) in
            guard let data = response.data else {return}
            do {
                let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                let items = groupsResponse.response.items
                print(items)
                completition(items)
            } catch {
                completition([])
            }
        }
    }
    
    func isLiked(ownerId: String?, token: String?, v: String?, itemId: String?, completition: @escaping(Int) -> Void){
        let urlComponents = communication(methodName: "isLiked", userId: ownerId.self, token: token.self, v: v.self, q: itemId.self)
        guard let url = urlComponents.url else {return}
        AF.request(url).responseData{ (response) in
            guard let data = response.data else {return}
            do {
                let isLikedResponse = try JSONDecoder().decode(IsLikedResponse.self, from: data)
                let liked = isLikedResponse.response.liked
                print(liked)
                completition(liked)
            } catch {
                completition(0)
            }
        }
    }
    func addLike(ownerId: String?, token: String?, v: String?, itemId: String?, completition: @escaping(Int) -> Void){
        let urlComponents = communication(methodName: "addLike", userId: ownerId.self, token: token.self, v: v.self, q: itemId.self)
        guard let url = urlComponents.url else {return}
        AF.request(url).responseData{ (response) in
            guard let data = response.data else {return}
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) //access denied. I don't know why. Can you tel me?
                let addLikeResponse = try JSONDecoder().decode(AddLikeResponse.self, from: data)
                let likes = addLikeResponse.response.likes
                print(likes)
                completition(likes)
            } catch {
                completition(0)
            }
        }
    }
    
}
