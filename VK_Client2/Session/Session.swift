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
    
    var token: String = ""
    var userId = 0
}
