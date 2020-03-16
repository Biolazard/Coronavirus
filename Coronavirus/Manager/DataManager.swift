//
//  DateManager.swift
//  Coronavirus
//
//  Created by Marius Lazar on 02/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation


protocol CoronavirusDelegate {
    func showData()
}

class DataManager {
    
    
    let coreData = DataController()
    var delegate: CoronavirusDelegate?
    var delegateee: CoronavirusDelegate!
    var coronavirus = [Covid19]() {
        didSet {
            self.delegate?.showData()
        }
    }
    
    init() {
        refreshData()
    }
    
    func refreshData() {
        getRightAPI(date: getToday())
    }
    
    private func getRightAPI(date: String) {
        if isOldDate(lastDate: coreData.getLastUpdate(), newDate: date) {
            Network.genericDownload(url: URL(string: "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/\(date).csv")!, completion: { c19 in
                if c19.isEmpty {
                    return self.getRightAPI(date: self.getRightDate(date: date))
                } else {
                    self.coreData.emptyData()
                    for covid in c19 {
                        self.coreData.insert(c19: covid)
                    }
                    self.coreData.insertLastUpdate(date: date)
                    self.coreData.getDataSpread { covid in
                        self.coronavirus = covid
                    }
                }
            }, handleError: { _ in
                self.coreData.getDataSpread { covid in
                    let covid = covid.isEmpty ? [Covid19]() : covid
                    self.coronavirus = covid
                }
            })
        } else {
            coreData.getDataSpread { covid in
                self.coronavirus = covid
                
            }
        }
    }
    
    private func getRightDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let calculateYesterday = dateFormatter.date(from: date)
        let yesterday = calculateYesterday!.timeIntervalSince1970 - 86400
        return dateFormatter.string(from: Date(timeIntervalSince1970: yesterday))
    }
    
    private func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: Date())
    }
    
    private func isOldDate(lastDate date1: String?, newDate date2: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        if let date1 = date1, let lastDate1970 = dateFormatter.date(from: date1)?.timeIntervalSince1970,
            let newDate1970 = dateFormatter.date(from: date2)?.timeIntervalSince1970 {
            return lastDate1970 < newDate1970 ? true : false
        } else {
            return true
        }
    }
}
