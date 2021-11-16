//
//  GroupsModel.swift
//  VK-client
//
//  Created by Artem Firsov on 10/20/21.
//

import Foundation

struct GroupModel: Decodable {
    var response: GroupResponse
}

struct GroupResponse: Decodable {
    var count = 0
    var items: [Group]
}

struct Group: Decodable, PostRepresentable {
    var photo: String { return photo_100 }
    
    var id = 0
    var photo_50 = ""
    var photo_100 = ""
    var name = ""
}
