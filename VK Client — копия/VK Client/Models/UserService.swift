//
//  UserService.swift
//  VK Client
//
//  Created by Анастасия Живаева on 14.04.2021.
//

import Foundation
import Alamofire

class UserService {
    
    let baseUrl = "https://api.vk.com"
    
    let user = Session.shared
    
    let count = 10
    
    func loadUserInfo() {
        let path = "/method/account.getProfileInfo?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "v": "5.130"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { repsonse in
                print("Информация о пользователе: \(String(describing: repsonse.value))")
        }
    }
    
    func loadFriends() {
        let path = "/method/friends.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "count": count,
            "v": "5.130"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { repsonse in
                print("Список друзей: \(String(describing: repsonse.value))")
        }
    }
    
    func loadUserPhotos() {
        let path = "/method/photos.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "count": "1",
            "album_id": "profile",
            "v": "5.130"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { repsonse in
                print("Фотографии пользователя: \(String(describing: repsonse.value))")
        }
    }
    
    func loadGroups() {
        let path = "/method/groups.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "count": count,
            "v": "5.130"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { repsonse in
                print("Группы пользователя: \(String(describing: repsonse.value))")
        }
    }
    func searchByUserGroups(searchText: String) {
        let path = "/method/search.getHints?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "q": searchText,
            "filters": "groups",
            "search_global": "1",
            "access_token": user.token,
            "v": "5.130"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { repsonse in
                print("Поиск по группам пользователя: \(String(describing: repsonse.value))")
        }
    }
    
}
