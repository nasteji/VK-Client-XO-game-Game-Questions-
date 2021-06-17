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
    @IBOutlet weak var viewColor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func color(color: UIColor, opacity: CGFloat) {
        print(color)
        viewColor.backgroundColor = color
        viewColor.alpha = opacity
    }
    
    func configure(news: News) {
        textNewsLabel.text = news.text
        textNewsLabel.sizeToFit()
    }
}
