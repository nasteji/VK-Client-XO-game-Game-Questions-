//
//  Group.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.02.2021.
//

import Foundation

class Group: Equatable {
    
    var groupName: String
    var groupImage: String?
    
    init(groupName: String, groupImage: String?) {
        self.groupName = groupName
        self.groupImage = groupImage
    }
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.groupName == rhs.groupName &&
        lhs.groupImage == rhs.groupImage
    }
}

extension Group {
    static var group1 = Group(groupName: "Подводная охота", groupImage: "акула")
    static var group2 = Group(groupName: "Вязание крючком", groupImage: "вязание")
    static var group3 = Group(groupName: "Программист от А до Я", groupImage: "swift")
    static var group4 = Group(groupName: "Кошки", groupImage: "кошки")
    static var group5 = Group(groupName: "Собаки", groupImage: "собаки")
    static var group6 = Group(groupName: "Как кошка с собакой", groupImage: "кошкисобаки")
    
    static func fakeAll() -> [Group] {
        return [.group1, .group2, .group3, .group4, .group5, .group6]
    }
    static func fakeFavorite() -> [Group] {
        return [.group1, .group2, .group3]
    }

}
