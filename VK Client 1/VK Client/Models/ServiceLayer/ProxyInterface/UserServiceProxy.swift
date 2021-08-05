//
//  UserServiceProxy.swift
//  VK Client
//
//  Created by Анастасия Живаева on 05.08.2021.
//

import Foundation

class UserServiceProxy: UserServiceInterface {
    
    let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func loadUserPhotos(id: Int, completion: @escaping () -> Void) {
        self.userService.loadUserPhotos(id: id, completion: completion)
        print("called func loadUserPhotos for id =\(id)")
    }
}
