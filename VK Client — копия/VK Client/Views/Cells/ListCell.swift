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
    
}
