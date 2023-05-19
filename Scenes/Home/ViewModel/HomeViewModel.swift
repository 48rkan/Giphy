//  HomeViewModel.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import UIKit

class HomeViewModel {
    
    public var items = [Datum]()
    
    public var successCallBack: (()->())?
 
    public init() {
//        getGifs(type: .trending)
    }
    
    public func getGifs(type: GifsType, query: String = "") {
        items.removeAll()
        HomeManager.fetchGifs(limit: 100,
                              type: type,
                              query: query) { items, error in
            if error != nil { return }

            guard let items = items?.data else { return }
            
            self.items = items
            
            self.successCallBack?()
        }
    }
        
    func resetData() {
        items.removeAll()
    }
}
