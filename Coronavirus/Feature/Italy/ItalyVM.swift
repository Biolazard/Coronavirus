//
//  ItalyVM.swift
//  Coronavirus
//
//  Created by Marius Lazar on 21/03/2020.
//  Copyright © 2020 Biolazard. All rights reserved.
//

import Foundation

class ItalyVM {
    
    var italy = [Italy]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate.table.reloadData()
            }
        }
    }
    
    private var notFilterItaly = [Italy]() {
        didSet {
            notFilterItaly.sort { (i1, i2) in
                i1.casiTotali > i2.casiTotali
            }
            italy = notFilterItaly
        }
    }
    
    private var filterItaly = [Italy]() {
        didSet {
            if isSearching {
                italy = filterItaly
            }
            
        }
    }
    var delegate: ItalyViewController!
    var isSearching: Bool = false {
        didSet {
            if !isSearching {
                italy = notFilterItaly
            }
        }
    }
    
    func update() {
        Network.getRegioneItaly(url: URL(string: "https://openpuglia.org/api/?q=getdatapccovid-19")!, completion: { italy in
            self.notFilterItaly = italy
        }) { error in }
        self.endRefreshing()
    }
    
    func updateWithSearch(text: String?) {
        isSearching = !(text?.isEmpty ?? true)
        filterItaly = notFilterItaly.filter({ region  in
            region.regione.contains(text ?? "")
        })
    }
    
    private func endRefreshing() {
        if let refresh = self.delegate.table.refreshControl, refresh.isRefreshing {
            self.delegate.table.refreshControl?.endRefreshing()
        }
        self.delegate.table.reloadData()
    }
    
}
