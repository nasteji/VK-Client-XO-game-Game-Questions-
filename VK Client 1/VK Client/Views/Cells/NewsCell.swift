//
//  NewsCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let reuseId = "NewsCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    @IBOutlet weak var likeControl: ILikeButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(news: News, group: Group) {
        
        nameLabel.text = group.name
        
        dateLabel.text = news.date.unixTime()
        
        textNewsLabel.text = news.text

        if let url = URL(string: group.photo) {
            let data = try? Data(contentsOf: url)
            imageViewAvatar.image = UIImage(data: data!)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }

        if let likes = news.likes {
            likeControl.button.setTitle(String(likes.count), for: .normal)
            if likes.userLikes == 1 {
                likeControl.isOn = true
            }
        }
        
        if let repost = news.reposts {
            repostButton.setTitle(String(repost.count), for: .normal)
        }
       
        if let comments = news.comments {
            commentButton.setTitle(String(comments.count), for: .normal)
        }
        
        if let photo = news.attachments?.first?.photo?.photo604 {
            let url = URL(string: photo)!
            let data = try? Data(contentsOf: url)
            imageNewsView.image = UIImage(data: data!)
        } else {
            if let photo = news.attachments?.first?.video?.photo320 {
                let url = URL(string: photo)!
                let data = try? Data(contentsOf: url)
                imageNewsView.image = UIImage(data: data!)
            } else {
                imageNewsView.image = UIImage(named: "placeholder")
            }
        }

        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
