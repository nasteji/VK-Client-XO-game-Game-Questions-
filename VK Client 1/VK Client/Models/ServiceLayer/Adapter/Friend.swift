//
//  Friend.swift
//  VK Client
//
//  Created by Анастасия Живаева on 22.07.2021.
//

import Foundation

struct Friend: People {
    var id: Int
    var firstName: String
    var lastName: String
    var photo: String
}

extension Friend {
    static func dictionary(users: [Friend]) -> [String: [Friend]] {
        
        let dictionary = users.reduce(into: [String: [Friend]]()) {
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
