//
//  TabBarViewController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    let coreData = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreData.fetchData()
        getRightAPI(date: getToday())
    }
    
    func getRightAPI(date: String) {
        
        Network.genericDownload(url: URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/archived_data/test/\(date).csv")!, completion: { c19 in
            if c19.isEmpty {
                return self.getRightAPI(date: self.getRightDate(date: date))
            } else {
//                self.addAnnotation(covid: c19)
                c19.forEach { singleC19 in
                    self.coreData.insert(c19: singleC19)
                    
                }
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
