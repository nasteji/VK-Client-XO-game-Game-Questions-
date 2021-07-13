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
    let dispatchGroup = DispatchGroup()
    private var userService = UserService()
    private var imageService: ImageService?
    
    private var lastDate: Double?
    var nextFrom = ""
    var isLoading = false
  
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageService = ImageService(container: tableView)
        setupRefreshControl()
        loadData()
        
        tableView.prefetchDataSource = self
        
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: NewsTextCell.reuseId)
        tableView.register(UINib(nibName: "NewsPhotoCell", bundle: nil), forCellReuseIdentifier: NewsPhotoCell.reuseId)
        
        let headerNib = UINib(nibName: "NewsHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: NewsHeaderView.reuseId)
        let footerNib = UINib(nibName: "NewsFooterView", bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: NewsFooterView.reuseId)
    }
   
    // MARK: - Service
    
    func loadData() {
        userService.loadNews() { [weak self] news, nextFrom in
            self?.news = news
            self?.nextFrom = nextFrom
            self?.lastDate = news.first!.date
            
            self?.dispatchGroup.notify(queue: DispatchQueue.main) {
                self?.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление...")
        tableView.refreshControl?.tintColor = .purple
        tableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        guard let date = lastDate
        else {
            tableView.refreshControl?.endRefreshing()
            return
        }
        userService.loadNewsWithTime(timeInterval1970: (date + 1)) { [weak self] news in
            guard let self = self else { return }
            self.news.insert(contentsOf: news, at: 0)
            if !news.isEmpty {
                self.lastDate = news.first!.date
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
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
        
        let post = news[indexPath.section]
        
        switch indexPath.row {
        case 0:
            return post.text == "" ? 0 : UITableView.automaticDimension
        case 1:
            if post.attachments?.first?.photo?.photo604 == nil {
                return 0
            }
            let aspectRatio = post.attachments?.first?.photo?.aspectRatio ?? 1
            return aspectRatio * view.frame.width
        default:
            return post.text == "" && post.attachments?.first?.photo?.photo604 == nil ? UITableView.automaticDimension : 0
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
        
        let post = news[indexPath.section]
    
        if let cell = cell as? NewsTextCell {
            cell.configure(news: post)
            cell.color(color: tableView.backgroundColor!, opacity: 1)
        }
        if let cell = cell as? NewsPhotoCell {
            guard let urlImage = post.attachments?.first?.photo?.photo604 else { return }

            let image = imageService?.photo(atIndexpath: indexPath, byUrl: urlImage)
            cell.configure(image: image)
        }
    }
    
}

extension NewsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }

        if maxSection > news.count - 3, !isLoading {
            isLoading = true

            userService.loadNewsWithNextFrom(nextFrom: nextFrom) { [weak self] news, nextFrom in
                self?.nextFrom = nextFrom

                guard let self = self else { return }
                let indexSet = IndexSet(integersIn: self.news.count..<self.news.count + news.count)
                self.news.append(contentsOf: news)
                DispatchQueue.main.async {
                    self.tableView.insertSections(indexSet, with: .automatic)
                }
                self.isLoading = false
            }
        }
    }
}
