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
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var dateTextCache: [Int: String] = [:]
    
    @IBOutlet weak var viewColor: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(news: News, section: Int) {
        dateLabel.text = getCellDateText(forsection: section, andTimestamp: news.date)
        nameLabel.text = news.sourceName

        if let urlImage = news.sourcePhoto {
            imageViewAvatar.imageView.loadImage(imageUrl: urlImage)
        }  else {
            imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    
    func getCellDateText(forsection section: Int, andTimestamp
    timestamp: Double) -> String {
        if let stringDate = dateTextCache[section] {
            return stringDate
        } else {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            dateTextCache[section] = stringDate
            return stringDate
        }
    }
    
}
