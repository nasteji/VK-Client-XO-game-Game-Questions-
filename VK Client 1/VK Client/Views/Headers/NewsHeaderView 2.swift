//
//  NewsHeaderView.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.05.2021.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {

    static let reuseId = "NewsHeaderView"
    static var height: CGFloat = 50
    
    @IBOutlet weak var viewColor: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(news: News) {
        dateLabel.text = news.date?.convertFromUnixTime()
        nameLabel.text = news.sourceName
        
        if let urlImage = news.sourcePhoto {
            imageViewAvatar.imageView.loadImage(imageUrl: urlImage)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    
}
