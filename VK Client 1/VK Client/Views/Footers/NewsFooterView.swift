//
//  NewsFooterView.swift
//  VK Client
//
//  Created by Анастасия Живаева on 03.06.2021.
//

import UIKit

class NewsFooterView: UITableViewHeaderFooterView {

    static let reuseId = "NewsFooterView"
    static var height: CGFloat = 35
    
    @IBOutlet weak var likeControl: ILikeButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!

    func configure(news: News) {

        likeControl.isOn = news.likes?.userLikes == 1 ? true : false
        
        likeControl.countLikes = news.likes?.count ?? 0
        likeControl.button.setTitle(String(news.likes?.count ?? 0), for: .normal)
        
        repostButton.setTitle(String(news.reposts?.count ?? 0), for: .normal)
        commentButton.setTitle(String(news.comments?.count ?? 0), for: .normal)
    }
    
    
}
