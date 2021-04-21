//
//  User.swift
//  VK Client
//
//  Created by Анастасия Живаева on 16.04.2021.
//

import Foundation

struct Friends: Codable {
    let response: FriendsResponse
}
struct FriendsResponse: Codable {
    let count: Int
    let items: [User]
}
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: URL
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
    
    static func fakeDictionary(users: [User]) -> [String: [User]] {
        
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
