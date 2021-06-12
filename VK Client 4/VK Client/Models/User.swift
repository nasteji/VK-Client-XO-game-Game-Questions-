//
//  User.swift
//  VK Client
//
//  Created by Анастасия Живаева on 16.04.2021.
//

import Foundation
import RealmSwift

struct Friends: Codable {
    let response: FriendsResponse
}
struct FriendsResponse: Codable {
    let count: Int
    let items: [User]
}
class User: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    var photo: URL
    var name: String {
        return firstName + " " + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
    
}
extension User {
    
    static func dictionary(users: [User]) -> [String: [User]] {
        
        let dictionary = users.reduce(into: [String: [User]]()) {
            result, name in
            
            if result["\(name.firstName.first!)"] == nil {
                result["\(name.firstName.first!)"] = [name]
            } else {
                result["\(name.firstName.first!)"]!.append(name)
            }
        }
        return dictionary
    }
}
