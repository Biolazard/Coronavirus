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
    
    func dependencyInjection(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
    }
    
    func showData() {
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.coronavirus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DailyReport
        cell.accessoryType = .disclosureIndicator
        let c19 = dataManager.coronavirus[indexPath.row]
        cell.country.text = c19.country
        cell.confirmed.text = "Confirmed \(c19.confirmed ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let c19 = dataManager.coronavirus[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "details") as! DetailViewController
        vc.injectDependices(data: c19)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
