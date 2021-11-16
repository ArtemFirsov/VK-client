//
//  Storage.swift
//  VK-Client
//
//  Created by Artem Firsov on 10/18/21.
//

import Foundation

class Storage: NSObject {
    static let shared = Storage()
    private override init() {
        super.init()
    }
    
    var token: String = ""
    var myId: String = "7978275"
}
