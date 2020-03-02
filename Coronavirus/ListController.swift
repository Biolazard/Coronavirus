//
//  TableViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource, CoronavirusDelegate {

    
    @IBOutlet weak var table: UITableView!
    
    var dataManager: DataManager!
    
    var c19 = [Covid19]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    func dependencyInjection(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.refreshData()
    }
    
    func showData(data: [Covid19]) {
        self.c19 = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c19.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DailyReport
        let c19 = self.c19[indexPath.row]
        cell.country.text = c19.country
        cell.confirmed.text = "Confirmed \(c19.confirmed ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c19 = self.c19[indexPath.row]
        let vc = DetailViewController()
        vc.injectDependices(data: c19)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
