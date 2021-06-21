//
//  UserExtension.swift
//  VK Client
//
//  Created by Анастасия Живаева on 17.06.2021.
//

import Foundation

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
