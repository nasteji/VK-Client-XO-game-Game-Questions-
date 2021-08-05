//
//  ListViewModelFactory.swift
//  VK Client
//
//  Created by Анастасия Живаева on 22.07.2021.
//

import UIKit

final class ListViewModelFactory {
    
    func constructUserViewModels(from users: [Friend]) -> [ListViewModel] {
        return users.compactMap(self.userViewModel)
    }
    
    private func userViewModel(from user: Friend) -> ListViewModel {
        let name = user.firstName + " " + user.lastName
        var photo = UIImage()
        
        if let url = URL(string: user.photo),
           let data = try? Data(contentsOf: url) {
            photo = UIImage(data: data)!
        } else {
            photo = UIImage(systemName: "person.fill")!
        }
        
        return ListViewModel(name: name, photo: photo)
    }
}
