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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.loadNews() { [weak self] news,groups  in
            self?.myNews = news
            self?.newsGroup = groups
            self?.tableView.reloadData()
        }

        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseId)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseId)
        tableView.register(UINib(nibName: "AllNewsCell", bundle: nil), forCellReuseIdentifier: AllNewsCell.reuseId)
        
        let headerNib = UINib(nibName: "NewsHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: NewsHeaderView.reuseId)
        let footerNib = UINib(nibName: "NewsFooterView", bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: NewsFooterView.reuseId)
    }
    
    // MARK: - Footer
    
    //данные в footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsFooterView.reuseId) as? NewsFooterView
        else { return nil }
        
        footerView.color(color: tableView.backgroundColor!, opacity: 1)
        
        if let likes = myNews[section].likes {
            footerView.likeControl.button.setTitle(String(likes.count), for: .normal)
            if likes.userLikes == 1 {
                footerView.likeControl.isOn = true
            }
        }
        if let repost = myNews[section].reposts {
            footerView.repostButton.setTitle(String(repost.count), for: .normal)
        }
       
        if let comments = myNews[section].comments {
            footerView.commentButton.setTitle(String(comments.count), for: .normal)
        }
        
        return footerView
    }
    //высота footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        NewsFooterView.height
    }
    
    // MARK: - Header
    
    //данные в header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.reuseId) as? NewsHeaderView
        else { return nil }

        headerView.color(color: tableView.backgroundColor!, opacity: 1)
        
        headerView.nameLabel.text = newsGroup[section].name
        headerView.dateLabel.text = myNews[section].date.unixTime()
        if let url = URL(string: newsGroup[section].photo) {
            let data = try? Data(contentsOf: url)
            headerView.imageViewAvatar.image = UIImage(data: data!)
        } else {
            headerView.imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }

        return headerView
    }
    //высота header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.height
    }
    
    // MARK: - Table view data source
    
    //кол-во секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return myNews.count
    }
    //кол-во строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = myNews[indexPath.section].attachments?.first?.photo?.photo604
        let text = myNews[indexPath.section].text
        
        //новость содержит текст и фото
        if text != "" && photo != nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AllNewsCell.reuseId, for: indexPath) as! AllNewsCell
            
            cell.textNewsLabel.text = myNews[indexPath.section].text
            cell.textNewsLabel.sizeToFit()
            
            let url = URL(string: photo!)!
            let data = try? Data(contentsOf: url)
            cell.imageNewsView.image = UIImage(data: data!)
            
            return cell
        }
        //новость содержит только фото
        if photo != nil {
                
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseId, for: indexPath) as! NewsPhotoCell
            
            let url = URL(string: photo!)!
            let data = try? Data(contentsOf: url)
            cell.imageNewsView.image = UIImage(data: data!)
            
            return cell
        }
        //новость содержит только текст
        if text != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseId, for: indexPath) as! NewsTextCell
            
            cell.textNewsLabel.text = myNews[indexPath.section].text
            cell.textNewsLabel.sizeToFit()
            
            return cell
        }
        
        //placeholder, если новость без фото и текста
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseId, for: indexPath) as! NewsPhotoCell
        cell.imageNewsView.image = UIImage(named: "placeholder")
        return cell
    }
            
            

      
}


