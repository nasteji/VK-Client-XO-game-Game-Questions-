//
//  NewsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import UIKit
import RealmSwift

class NewsViewController: UITableViewController {

    var news: [News] = []
    private var userService = UserService()
    private var imageService: ImageService?
  
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageService = ImageService(container: tableView)
        
        loadData()
       
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseId)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseId)
        
        let headerNib = UINib(nibName: "NewsHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: NewsHeaderView.reuseId)
        let footerNib = UINib(nibName: "NewsFooterView", bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: NewsFooterView.reuseId)
    }
   
    // MARK: - Service
    
    func loadData() {
        userService.loadNews() { [weak self] news, groups, profiles in
            self?.news = news
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Footer
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsFooterView.reuseId) as? NewsFooterView
        else { return nil }
        
        footerView.configure(news: news[section])
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        NewsFooterView.height
    }
    
    // MARK: - Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.reuseId) as? NewsHeaderView
        else { return nil }

        headerView.configure(news: news[section], section: section)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.height
    }
    
    // MARK: - Table view data source
    
    //кол-во секций в таблице
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    //кол-во строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    //высота ячеек
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let news = news[indexPath.section]
        
        switch indexPath.row {
        case 0:
            return news.text == "" ? 0 : UITableView.automaticDimension
        case 1:
            return news.attachments?.first?.photo?.photo604 == nil ? 0 : UITableView.automaticDimension
        default:
            return news.text == "" && news.attachments?.first?.photo?.photo604 == nil ? UITableView.automaticDimension : 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseId, for: indexPath) as! NewsTextCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseId, for: indexPath) as! NewsPhotoCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseId, for: indexPath) as! NewsPhotoCell
            cell.imageNewsView.image = UIImage(named: "placeholder")
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let news = news[indexPath.section]
    
        if let cell = cell as? NewsTextCell {
            cell.configure(news: news)
            cell.color(color: tableView.backgroundColor!, opacity: 1)
        }
        if let cell = cell as? NewsPhotoCell {
            guard let urlImage = news.attachments?.first?.photo?.photo604 else { return }

            let image = imageService?.photo(atIndexpath: indexPath, byUrl: urlImage)
            cell.configure(image: image)
        }
    }
            
            

      
}


