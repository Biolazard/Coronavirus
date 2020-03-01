//
//  DataController.swift
//  Coronavirus
//
//  Created by Marius Lazar on 28/02/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {

    
    private var persistentContainer: NSPersistentContainer
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "Coronavirus")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data \(error)")
            }
        }
    }
    
    func insert(c19: Covid) {
        let manageContext = self.persistentContainer.viewContext
        let caseOfCoronavirus = NSEntityDescription.insertNewObject(forEntityName: "Coronavirus", into: manageContext) as! Covid19
        caseOfCoronavirus.confirmed = c19.confirmed
        caseOfCoronavirus.country = c19.country
        caseOfCoronavirus.recovered = c19.recovered
        caseOfCoronavirus.deaths = c19.deaths
        caseOfCoronavirus.lastUpdate = c19.lastUpdate
        caseOfCoronavirus.latitude = c19.coordinates.latitude
        caseOfCoronavirus.longitude = c19.coordinates.longitude
        do {
            try manageContext.save()
        } catch {
            debugPrint("ERROR SAVE CORE DATA \(error)")
        }
    }
    
    func fetchData() {
        let fetch = NSFetchRequest<Covid19>(entityName: "Coronavirus")
        do {
            let datas = try persistentContainer.viewContext.fetch(fetch)
            print("DATA FETCHED \(datas.count)")
        } catch {
            debugPrint("ERROR FETCH CORE DATA \(error)")
        }
    }
}
