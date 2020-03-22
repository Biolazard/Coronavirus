//
//  ItalyViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 21/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class ItalyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    
    @IBOutlet weak var table: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var model: ItalyVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.update()
        initRefreshController()
        initSearchController()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.italy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "italyCell", for: indexPath) as! DailyReportCell
        cell.accessoryType = .disclosureIndicator
        let region = model.italy[indexPath.row]
        cell.country.text = region.regione
        cell.confirmed.text = "Casi totali \(region.casiTotali)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let region = model.italy[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "regione") as! RegioneViewController
        vc.data = region
        vc.title = region.regione
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func update() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.model.update()
        }
    }
    
    private func initRefreshController() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(update), for: .valueChanged)
        table.refreshControl = refreshControl
    }
    
    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Cerca regione"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        model.updateWithSearch(text: text)
    }
    
}
