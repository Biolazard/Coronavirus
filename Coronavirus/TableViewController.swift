//
//  TableViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var table: UITableView!
    var c19 = [Covid]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRightAPI(date: getToday())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c19.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let c19 = self.c19[indexPath.row]
        cell.textLabel?.text = ("\(c19.country), death \(c19.deaths), recovered \(c19.recovered), confirmed \(c19.confirmed)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c19 = self.c19[indexPath.row]
        let vc = DetailViewController()
        vc.injectDependices(data: c19)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func getRightAPI(date: String) {
            
            Network.genericDownload(url: URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/archived_data/test/\(date).csv")!, completion: { c19 in
                if c19.isEmpty {
                    return self.getRightAPI(date: self.getRightDate(date: date))
                } else {
                    self.c19 = c19
                }
            })
        }
        
        
        func getRightDate(date: String) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let calculateYesterday = dateFormatter.date(from: date)
            let yesterday = calculateYesterday!.timeIntervalSince1970 - 86400
            return dateFormatter.string(from: Date(timeIntervalSince1970: yesterday))
        }
        
        func getToday() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            return dateFormatter.string(from: Date())
        }

}
