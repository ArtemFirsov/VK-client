//
//  NewsFeedModel.swift
//  VK-client
//
//  Created by Artem Firsov on 10/20/21.
//

import Foundation

protocol PostRepresentable: Decodable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct NewsFeedModel: Decodable {
    var response: NewsResponse
}

struct NewsResponse: Decodable {
    let items: [News]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - News
struct News: Decodable {
    let comments: CountableItems?
    let likes: CountableItems?
    let reposts: CountableItems?
    let views: CountableItems?
    let postType: String?
    let date: Double
    let sourceID: Int
    let text: String?
    let attachments: [Attachment]?
    let postID: Int?
    var sourceName: String?
    var sourcePhoto: String?

    enum CodingKeys: String, CodingKey {
        case comments, likes, reposts, views
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case attachments
        case postID = "post_id"
        case sourceName, sourcePhoto
    }
}

struct CountableItems: Decodable {
    let count: Int
}



// MARK: - Attachment
struct Attachment: Decodable {
    let type: String?
    let photo: PostPhoto?
}

// MARK: - Photo
struct PostPhoto: Decodable {
    let id: Int
    let accessKey: String?
    let userID: Int?
    let postId: Int?
    let date, ownerID: Int?
    let text: String?
    let hasTags: Bool?
    let albumID: Int?
    let sizes: [Size]
    
    private func getSize() -> Size {
        if let size = sizes.first(where: { (typeSizes) in
            typeSizes.type == "x"
        }) {
        return size
        } else if let anotherSize = sizes.last {
            return anotherSize
        } else {
            return Size(url: "nothing", type: "no type", width: 0, height: 0)
        }

    }

    var height: Int {
        return getSize().height
    }
    
    var width: Int {
        return getSize().width
    }
    
    var url: String {
        return getSize().url
    }
    enum CodingKeys: String, CodingKey {
        case id
        case postId = "post_id"
        case accessKey = "access_key"
        case userID = "user_id"
        case date
        case ownerID = "owner_id"
        case text //, height
        case hasTags = "has_tags"
        case albumID = "album_id"
        case sizes
    }
}

struct Size: Decodable {
    let url: String
    let type: String
    let width: Int
    let height: Int
}
// MARK: - Reposts
struct Reposts: Decodable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Profile
struct Profile: Decodable, PostRepresentable {
    var id: Int
    var name: String { return fullName ?? ""}
    var photo: String { return photo100 ?? ""}
//    let id: Int
    let photo100: String?
    let lastName: String?
    let sex: Int?
    let screenName, firstName: String?
    var fullName: String? {
        if firstName == "" && lastName == "" {
            return "No name"
        } else {
            return (firstName ?? "") + " " + (lastName ?? "")
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}
