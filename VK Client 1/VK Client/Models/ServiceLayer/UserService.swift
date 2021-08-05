//
//  UserService.swift
//  VK Client
//
//  Created by Анастасия Живаева on 14.04.2021.
//

import Foundation
import Alamofire
import RealmSwift

class UserService: UserServiceInterface {
    
    let user = Session.shared
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.21"
    
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Friends
    func loadFriends() {
        
        let path = "friends.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "fields": "photo_100",
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let users = try JSONDecoder().decode(Friends.self, from: data)
                    self?.saveFriendsData(friends: users.response.items)
                } catch {
                    print(error)
                }
        }
    }
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
    
    // MARK: - Photos
    func loadUserPhotos(id: Int, completion: @escaping() -> Void) {
                     
        let path = "photos.getAll?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "owner_id": id,
            "access_token": user.token,
            "no_service_albums": 0,
            "count": 20,
            "extended": 1,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let photos = try JSONDecoder().decode(Album.self, from: data)
                    self?.savePhotosData(photo: photos.response.items)
                    completion()
                } catch {
                    print(error)
                }
        }
    }
    func savePhotosData(photo: [Photo]) {
        do {
           
            let realm = try Realm()
            
            let oldPhotos = realm.objects(Photo.self)
            realm.beginWrite()
            realm.delete(oldPhotos)

            realm.add(photo)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Groups
    func loadGroups(completion: @escaping() -> Void) {
        let path = "groups.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "extended": 1,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let groups = try JSONDecoder().decode(GroupList.self, from: data)
                    self?.saveGroupsData(groups: groups.response.items)
                    completion()
                } catch {
                    print(error)
                }
        }
    }
    func saveGroupsData(groups: [Group]) {
        do {
            let realm = try Realm()
            
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)

            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Search Groups
    func searchByUserGroups(searchText: String, completion: @escaping([Group]) -> Void) {
        let path = "groups.search"
        let url = baseUrl+path
        let parameters: Parameters = [
            "q": searchText,
            "type": "group",
            "sort": 0,
            "access_token": user.token,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                do {
                    let groups = try JSONDecoder().decode(GroupList.self, from: data)
                    completion(groups.response.items)
                } catch {
                    print(error)
                }
        }
    }
    
    // MARK: - News
    func loadNews(completion: @escaping([News], String) -> Void) {

        let path = "newsfeed.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "filters": "post",
            "count": "20",
            "v": version
        ]

        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
                do {
                    let newsList = try JSONDecoder().decode(NewsList.self, from: data).response
                    let nextFrom = newsList.nextFrom
                    let news = self.fillingNews(newsList)
                    
                    DispatchQueue.global().async(group: self.dispatchGroup) {
                        completion(news, nextFrom ?? "")
                    }
                } catch {
                    print(error)
                }
        }
    }
   
    func loadNewsWithNextFrom(nextFrom: String, completion: @escaping([News], String) -> Void) {

        let path = "newsfeed.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "filters": "post",
            "start_from": nextFrom,
            "count": "20",
            "v": version
        ]

        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
                do {
                    let newsList = try JSONDecoder().decode(NewsList.self, from: data).response
                    let nextFrom = newsList.nextFrom
                    let news = self.fillingNews(newsList)
                    
                    DispatchQueue.global().async(group: self.dispatchGroup) {
                        completion(news, nextFrom ?? "")
                    }
                } catch {
                    print(error)
                }
        }
    }
   
    func loadNewsWithTime(timeInterval1970: Double, completion: @escaping([News]) -> Void) {

        let path = "newsfeed.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "filters": "post",
            "start_time": timeInterval1970,
            "count": "10",
            "v": version
        ]

        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
                do {
                    let newsList = try JSONDecoder().decode(NewsList.self, from: data).response
                    let news = self.fillingNews(newsList)
                    
                    DispatchQueue.global().async(group: self.dispatchGroup) {
                        completion(news)
                    }
                } catch {
                    print(error)
                }
        }
        
    }
    
    func fillingNews(_ newsList: NewsResponse) -> [News] {
        var news = newsList.items
        let groups = newsList.groups
        let profiles = newsList.profiles
        
        for index in 0..<news.count {
            var id = news[index].sourceID
            if id! > 0 {
                let profile = profiles?.first(where: { $0.id == id })
                news[index].sourceName = profile?.name
                news[index].sourcePhoto = profile?.photo
            } else {
                id!.negate()
                let group = groups?.first(where: { $0.id == id })
                news[index].sourceName = group?.name
                news[index].sourcePhoto = group?.photo
            }
        }
        return news
    }
}
