//
//  NewsViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 06/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableNews: UITableView!
    var dataManager: DataManager!
    var news: News? {
        didSet {
            DispatchQueue.main.async {
                self.tableNews.reloadData()
            }
        }
    }
    
    func dependencyInjection(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.getNews(completionHandler: { news in
            self.news = news
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        news?.articles.count ?? 0
        let a = news?.articles.filter({ article -> Bool in
            article.urlToImage != nil && article.urlToImage?.contains("https") ?? false && article.url.contains("https")
        })
        return a?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as! ArticleCell
        cell.imageArticle.layer.cornerRadius = 8
        if let news = news {
            let newsPerCell = news.articles[indexPath.row]
            cell.editor.text = newsPerCell.source.name
            cell.title.text = newsPerCell.title
            cell.imageArticle.kf.setImage(with: URL(string: newsPerCell.urlToImage ?? ""))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let news = news {
            let newsPerCell = news.articles[indexPath.row]
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "web") as! WebViewViewController
            vc.dependencyInjection(url: URL(string: newsPerCell.url)!)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func infoAbountNews(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Powered by News API", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: "https://newsapi.org/")!, options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
