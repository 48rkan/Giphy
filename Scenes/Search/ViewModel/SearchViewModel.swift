//
//  SearchViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import Foundation

class SearchViewModel {
    
    var items = [Datums]()
    var successCallBack: (()->())?
    
    init() {
//        fetchRelativeChannel(query: "tiktok")
    }
    func fetchRelativeChannel(query: String) {
        SearchManager.fetchRelativeChannel(query: query) { items, error in
            if error != nil { print(error?.localizedDescription)}
            
            guard let items = items?.data else { return }
            self.items = items
            self.successCallBack?()
        }
    }
    
    func fetchRelatedTags(tags: String) {
        TableInUIViewManager.fetchRelatedTags(tags: tags) { items, error in
            
            if error != nil { print(error?.localizedDescription)}
            
            guard let items = items else { return }
            print(items.meta)
        }
    }
}
