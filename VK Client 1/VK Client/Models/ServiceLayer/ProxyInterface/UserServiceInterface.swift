//
//  UserServiceInterface.swift
//  VK Client
//
//  Created by Анастасия Живаева on 05.08.2021.
//

import Foundation

protocol UserServiceInterface {
    func loadUserPhotos(id: Int, completion: @escaping() -> Void)
}
