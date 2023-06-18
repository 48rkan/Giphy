//  HomeViewModel.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import UIKit

class HomeViewModel {
    public var items = [Datum]()
    public var successCallBack: (()->())?

    var currentSituation: (GifsType,String) = (.trending , "Trending")
    
    public func getGifs(type: GifsType, query: String = "") {
        HomeManager.fetchGifs(limit: 100,
                              type: type,
                              query: query) { items, error in
            if error != nil { return }

            guard let items = items?.data else { return }
            self.items = items
            
            self.successCallBack?()
        }
    }
}

extension HomeViewModel {
    var defaultGif: String {
        "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDIxZmEyOTNjNzQ5MDYxNzk4ZTYyOWY0MzIyYTU4ZDJjNWQyMThiOCZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/xTkcEQACH24SMPxIQg/giphy.gif"
    }
}
