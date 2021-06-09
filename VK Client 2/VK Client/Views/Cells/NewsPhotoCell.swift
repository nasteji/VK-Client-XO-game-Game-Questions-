//
//  NewsPhotoCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.05.2021.
//

import UIKit

class NewsPhotoCell: UITableViewCell {
    
    static let reuseId = "NewsPhotoCell"
    
    @IBOutlet weak var imageNewsView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configure(news: News) {
        guard let photo = news.attachments?.first?.photo?.photo604 else {
            return
        }
        let url = URL(string: photo)
        let data = try? Data(contentsOf: url!)
        imageNewsView.image = UIImage(data: data!)
    }

    
}
