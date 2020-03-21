//
//  NewsVM.swift
//  Coronavirus
//
//  Created by Marius Lazar on 17/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation
import UIKit

class NewsVM {
    
    
    var delegate: NewsViewController! {
        didSet {
            downloadNews()
        }
    }
    private var news: News?
    private var alert = Activity(title: nil, message: nil, preferredStyle: .alert)
    
    private func downloadNews(showAlert: Bool = true) {
        if showAlert {
            delegate.present(alert, animated: true, completion: nil)
        }
        Network.getNews(completionHandler: { news in
            self.delegate.dismiss(animated: true) {
                self.news = news
                if (self.news != nil) {
                    self.news!.articles = news.articles.filter { article -> Bool in
                        if let url = article.url, let URL = URL(string: url) {
                            return UIApplication.shared.canOpenURL(URL)
                        }
                        return false
                    }
                }
                self.endRefreshing()
            }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        var count = 0
        if let news = news {
            count = news.articles.count
        }
        return count
    }
    
    func getArticles() -> [Article] {
        var articles = [Article]()
        if let articleAvailable = news?.articles {
            articles = articleAvailable
        }
        return articles
    }
    
    @objc func updateNews() {
        downloadNews(showAlert: false)
    }
    
    private func endRefreshing() {
        if let refresh = self.delegate.tableNews.refreshControl, refresh.isRefreshing {
            self.delegate.tableNews.refreshControl?.endRefreshing()
        }
        self.delegate.tableNews.reloadData()
    }
    
}
