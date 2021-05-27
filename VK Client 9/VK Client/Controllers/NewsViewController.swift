//
//  NewsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import UIKit
import RealmSwift

class NewsViewController: UITableViewController {

    var myNews: [News] = []
    var newsGroup: [Group] = []
    
    var token = NotificationToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.loadNews() { [weak self] news,groups  in
            self?.myNews = news
            self?.newsGroup = groups
            self?.tableView.reloadData()
        }

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.reuseId)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        
        cell.configure(news: myNews[indexPath.row], group: newsGroup[indexPath.row])
        cell.sizeToFit()
        
        return cell
    }
    
}

