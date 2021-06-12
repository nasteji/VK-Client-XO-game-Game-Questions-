//
//  Group.swift
//  VK Client
//
//  Created by Анастасия Живаева on 21.04.2021.
//

import Foundation
import RealmSwift

struct GroupList: Codable {
    let response: GroupResponse
}
struct GroupResponse: Codable {
    let count: Int
    let items: [Group]
}
class Group: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    let screenName: String
    let photo: URL
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case photo = "photo_100"
        case screenName = "screen_name"
    }
}

