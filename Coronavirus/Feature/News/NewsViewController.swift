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
    var model: NewsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        initRefreshController() 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as! ArticleCell
        cell.imageArticle.layer.cornerRadius = 8
        let newsPerCell = model.getArticles()[indexPath.row]
        cell.editor.text = newsPerCell.source.name
        cell.title.text = newsPerCell.title
        cell.imageArticle.kf.setImage(with: URL(string: newsPerCell.urlToImage ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsPerCell = model.getArticles()[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "web") as! WebViewViewController
        if let strinUrl = newsPerCell.url, let url = URL(string: strinUrl) {
            vc.url = url
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
    
    @objc private func updateNews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.model.updateNews()
        }
        
    }
    private func initRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(updateNews), for: .valueChanged)
        tableNews.refreshControl = refreshControl
    }
}
