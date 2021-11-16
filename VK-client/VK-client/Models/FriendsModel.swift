//
//  FriendsModel.swift
//  VK-client
//
//  Created by Artem Firsov on 10/18/21.
//

import Foundation

struct FriendsModel: Decodable {
    var response: Responce
}

struct Responce: Decodable {
    var count = 0
    var items = [User]()
}

struct User: Decodable {
    var id = 0
    var last_name = ""
    var photo_50 = ""
    var first_name = ""
    
}
