//  SearchViewModel.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class SearchViewModel {
    
    var items = [Datums]()
    var successCallBack: (()->())?
    
    var currentText = String()
    
    func fetchRelativeChannel(query: String) {
        SearchManager.fetchRelativeChannel(query: query,
                                           type: .relativeChannels) { items, error in
            if error != nil { return }
            
            guard let items = items?.data else { return }
            self.items = items
            self.successCallBack?()
        }
    }
}
