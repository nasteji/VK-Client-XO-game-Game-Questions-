//
//  Group.swift
//  VK Client
//
//  Created by Анастасия Живаева on 21.04.2021.
//

import Foundation

struct GroupList: Codable {
    let response: GroupResponse
}
struct GroupResponse: Codable {
    let count: Int
    let items: [Group]
}
struct Group: Codable, Equatable {
    let id: Int
    let name: String
    let screenName: String
    let photo: URL
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case photo = "photo_100"
        case screenName = "screen_name"
    }
    static func == (lhs: Group, rhs: Group) -> Bool {
        return
            lhs.id == rhs.id
    }
}

