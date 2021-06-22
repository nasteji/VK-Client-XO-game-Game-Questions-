//
//  FriendsFotoCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 15.06.2021.
//

import UIKit

class FriendsFotoCell: UICollectionViewCell {
    
    static let reuseId = "FriendsFotoCell"

    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var iLikeButton: ILikeButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(photo: Photo) {
        
        if let photo = photo.photo604 {
            let url = URL(string: photo)!
            let data = try? Data(contentsOf: url)
            friendImage.image = UIImage(data: data!)
        } else {
            friendImage.image = UIImage(systemName: "person.fill")
        }

        iLikeButton.countLikes = photo.likes?.count
        iLikeButton.button.setTitle(String(photo.likes?.count ?? 0), for: .normal)
        iLikeButton.isOn = photo.likes?.userLikes == 1 ? true: false
    }
}
