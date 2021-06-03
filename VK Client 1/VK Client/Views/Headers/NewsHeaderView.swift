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
        print(color)
        viewColor.backgroundColor = color
        viewColor.alpha = opacity
    }
    
}
