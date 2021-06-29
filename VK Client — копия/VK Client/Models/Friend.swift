//
//  User.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.02.2021.
//

import Foundation

class Friend {
    var friendName: String
    var friendImage: String?
    var friendGallery: [String]?
    
    init(friendName: String, friendImage: String?, friendGallery: [String]?) {
        self.friendName = friendName
        self.friendImage = friendImage
        self.friendGallery = ["кошки", "собаки", "кошкисобаки"]
        self.friendGallery?.insert(friendImage ?? "фон", at: 0)
    }
}

extension Friend {
    
    static var friend1 = Friend(friendName: "Сергей", friendImage: "сергей", friendGallery: nil)
    static var friend2 = Friend(friendName: "Ларри", friendImage: "ларри", friendGallery: nil)
    static var friend3 = Friend(friendName: "Юлия Ведрова", friendImage: "ведро", friendGallery: nil)
    static var friend4 = Friend(friendName: "Анна", friendImage: "дама", friendGallery: nil)
    static var friend5 = Friend(friendName: "Лео", friendImage: "леопольд", friendGallery: nil)
    static var friend6 = Friend(friendName: "Рик", friendImage: "рик", friendGallery: nil)
    static var friend7 = Friend(friendName: "Морти", friendImage: "морти", friendGallery: nil)
    static var friend8 = Friend(friendName: "Я Личность", friendImage: "птичьяличность", friendGallery: nil)
    static var friend9 = Friend(friendName: "Бобби", friendImage: "губкабоб", friendGallery: nil)
    static var friend10 = Friend(friendName: "Мини-джедай", friendImage: "зел", friendGallery: nil)
    static var friend11 = Friend(friendName: "Екатерина", friendImage: "катя", friendGallery: nil)
    static var friend12 = Friend(friendName: "Оголтелая", friendImage: "кряква", friendGallery: nil)
    static var friend13 = Friend(friendName: "Анастасия", friendImage: nil, friendGallery: nil)
    
    static func fake() -> [Friend] {
        return [.friend1, .friend2, .friend3, friend4, friend5, friend6, friend7, friend8, friend9, friend10, friend11, friend12, friend13]
    }
    
    static func fakeDictionary() -> [String: [Friend]] {
        let myFriends = Friend.fake()
        
        let dictionary = myFriends.reduce(into: [String: [Friend]]()) {
            
            result, name in
            
            if result["\(name.friendName.first!)"] == nil {
                result["\(name.friendName.first!)"] = [name]
            } else {
                result["\(name.friendName.first!)"]!.append(name)
            }
        }
        return dictionary
    }
}
