//
//  Photo.swift
//  VK Client
//
//  Created by Анастасия Живаева on 16.04.2021.
//

import Foundation
import RealmSwift

struct Album: Codable {
    let response: AlbumResponse
}
struct AlbumResponse: Codable {
    let count: Int
    let items: [Photo]
}
class Photo: Object, Codable {
    @objc dynamic var owner: Int
    @objc dynamic var photo: String?
    @objc dynamic var likes: PhotoLikes?
    
    enum CodingKeys: String, CodingKey {
        case likes
        case owner = "owner_id"
        case photo = "photo_1280"
    }
}
class PhotoLikes: Object, Codable {
    @objc dynamic var userLikes: Int
    @objc dynamic var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}
