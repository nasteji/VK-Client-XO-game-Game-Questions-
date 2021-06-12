//
//  Photo.swift
//  VK Client
//
//  Created by Анастасия Живаева on 16.04.2021.
//

import Foundation

struct Album: Codable {
    let response: AlbumResponse
}
struct AlbumResponse: Codable {
    let count: Int
    let items: [Photo]
}
struct Photo: Codable {
    let sizes: [Sizes]
}
struct Sizes: Codable {
    let type: String
    let url: URL
}
