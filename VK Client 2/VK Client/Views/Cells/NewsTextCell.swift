//
//  NewsTextCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.05.2021.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    static let reuseId = "NewsTextCell"
    
    @IBOutlet weak var textNewsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(news: News) {
        textNewsLabel.text = news.text
        textNewsLabel.sizeToFit()
    }
}
