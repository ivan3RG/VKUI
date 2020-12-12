//
//  Services.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 09.12.2020.
//

import Foundation
import Alamofire

class Services {
    func friendsList(userId: String?, token: String?, v: String?){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/friends.get"
                urlComponents.queryItems = [
                    //URLQueryItem(name: "user_ids", value: userId),
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: v),
                    URLQueryItem(name: "fields", value: "nickname")
                ]
        guard let url = urlComponents.url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print(data)
            print(response)
            print(error)
        
            if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        task.resume()
    }
    
    func photos(userId: String?, token: String?, v: String?){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/photos.getAll"
                urlComponents.queryItems = [
                    //URLQueryItem(name: "user_ids", value: userId),
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: v),
                ]
        guard let url = urlComponents.url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print(data)
            print(response)
            print(error)
        
            if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        task.resume()
    }
    
    func groups(userId: String?, token: String?, v: String?){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.get"
                urlComponents.queryItems = [
                    //URLQueryItem(name: "user_ids", value: userId),
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: v),
                    URLQueryItem(name: "fields", value: "name"),
                    URLQueryItem(name: "extended", value: "1")
                ]
        guard let url = urlComponents.url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print(data)
            print(response)
            print(error)
        
            if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        task.resume()
    }
    
    func groupsSearch(userId: String?, token: String?, v: String?){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "api.vk.com"
                urlComponents.path = "/method/groups.search"
                urlComponents.queryItems = [
                    URLQueryItem(name: "access_token", value: token),
                    URLQueryItem(name: "v", value: v),
                    URLQueryItem(name: "q", value: "GeekBrains")//TestValue
                ]
        guard let url = urlComponents.url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print(data)
            print(response)
            print(error)
        
            if let data = data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        task.resume()
    }
}
