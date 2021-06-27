//
//  PromiseService.swift
//  VK Client
//
//  Created by Анастасия Живаева on 17.06.2021.
//

import Foundation
import RealmSwift
import PromiseKit

class PromiseService {
    
    private var urlConstructor = URLComponents()
    private let session = URLSession(configuration: .default)
    let user = Session.shared
    
    func saveFriendsData(friends: [User]) {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL as Any)

            let oldFriends = realm.objects(User.self)
            realm.beginWrite()
            realm.delete(oldFriends)

            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func getUrl() -> Promise<URL> {
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "user_ids", value: user.userId),
            URLQueryItem(name: "access_token", value: user.token),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "v", value: "5.21"),
        ]

        return Promise  { resolver in
            guard let url = urlConstructor.url else {
                resolver.reject(AppError.notCorrectUrl)
                return
            }
            resolver.fulfill(url)
        }
    }

    func getData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) {  (data, response, error) in
                guard let data = data else {
                    resolver.reject(AppError.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }

    func getParsedData(_ data: Data) -> Promise<[User]> {
        return Promise  { resolver in
            do {
                let response = try JSONDecoder().decode(Friends.self, from: data).response.items
                self.saveFriendsData(friends: response)
                resolver.fulfill(response)
            } catch {
                resolver.reject(AppError.failedToDecode)
            }
        }
    }

}

