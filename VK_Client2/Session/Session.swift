//
//  Session.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 26.11.2020.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token: String? = nil
    var userId: String? = nil
    let v: String? = "5.126"
}
