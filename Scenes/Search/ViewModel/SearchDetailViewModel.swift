//
//  SearchDetailViewModel.swift
//  Giphy
//  Created by Erkan Emir on 20.05.23.

import Foundation

class SearchDetailViewModel {
    var accountDatas: [Datums]
    var text = String()
    
    var items = [Datum]()
    var succesCallBack: (()->())?
    
    init(items: [Datums] = [Datums]()) {
        self.accountDatas = items
    }
    
    func fetchMatchesGifs() {
        SearchManager.fetchMatchesGifs(text: text) { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.items = items
            self.succesCallBack?()
        }
    }
}
