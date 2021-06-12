//
//  MyFriendsCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 12.03.2021.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let reuseID = "Cell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    
    func configure(user: User) {
        nameLabel.text = user.name
        if let data = try? Data(contentsOf: user.photo) {
            imageViewAvatar.image = UIImage(data: data)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    func configure(group: Group) {
        nameLabel.text = group.name
        if let data = try? Data(contentsOf: group.photo) {
            imageViewAvatar.image = UIImage(data: data)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }
    }
}
