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

    func color(color: UIColor, opacity: CGFloat) {
        viewColor.backgroundColor = color
        viewColor.alpha = opacity
    }
    
    func configure(news: News) {
        dateLabel.text = news.date!.convertFromUnixTime()
        nameLabel.text = news.sourceName

        if let photo = news.sourcePhoto {
            let url = URL(string: photo)!
            let data = try? Data(contentsOf: url)
            imageViewAvatar.image = UIImage(data: data!)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    
}
