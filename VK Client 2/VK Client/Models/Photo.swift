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
    @objc dynamic var photo130: String?
    @objc dynamic var photo604: String?
    @objc dynamic var photo75: String?
    @objc dynamic var photo807: String?
    @objc dynamic var photo1280: String?
    @objc dynamic var photo2560: String?
    @objc dynamic var likes: PhotoLikes?
    
    enum CodingKeys: String, CodingKey {
        case likes
        case owner = "owner_id"
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case photo2560 = "photo_2560"
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
