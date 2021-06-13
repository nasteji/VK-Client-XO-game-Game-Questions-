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
    
    func configure(news: News, source: SourceNews) {
        
        dateLabel.text = news.date!.unixTime()
        
        if source.group == nil {
            nameLabel.text = (source.profile?.firstName ?? "") + " " + (source.profile?.lastName ?? "")

            if let url = URL(string: source.profile!.photo!) {
                let data = try? Data(contentsOf: url)
                imageViewAvatar.image = UIImage(data: data!)
            } else {
                imageViewAvatar.image = UIImage(systemName: "person.fill")
            }
        } else {
            nameLabel.text = source.group?.name
            
            if let url = URL(string: source.group!.photo) {
                let data = try? Data(contentsOf: url)
                imageViewAvatar.image = UIImage(data: data!)
            } else {
                imageViewAvatar.image = UIImage(systemName: "person.3.fill")
            }
        }
    }
    
}
