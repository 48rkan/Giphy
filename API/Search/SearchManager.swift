//  SearchManager.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class SearchManager: SearchProtocol {
    
    static func fetchMatchesGifs(text: String,
                                 type:HomeEndPoint,
                                 completion: @escaping (Trending?,Error?)->()) {
        
        var url = ""
        
        switch type {
        case .common: url = HomeEndPoint.common.path() + "&q=\(text)"
        case _      : break
        }
        
        CoreManager.request(type: Trending.self,
                            url: url) { items, error in
            completion(items,error)
        }
    }
    
    static func fetchRelativeChannel(query: String,
                                     type: SearchEndPoint,
                                     completion: @escaping (RelativeChannel?,Error?)->()) {
        var url = ""
        
        switch type {
        case .relativeChannels:
            url = SearchEndPoint.relativeChannels.path() + "&q=\(query)"
        default: break
        }
        
        CoreManager.request(type: RelativeChannel.self,
                            url: url ) { items, error in
            completion(items,error)
        }
    }
}
