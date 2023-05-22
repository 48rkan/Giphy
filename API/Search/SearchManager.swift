//  SearchManager.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class SearchManager: SearchProtocol {
    
    static func fetchMatchesGifs(text: String,
                                 completion: @escaping (Trending?,Error?)->()) {
        
        CoreManager.request(type: Trending.self,
                            url: HomeEndPoint.common.path() + "&q=\(text)") { items, error in
            completion(items,error)
        }
    }
    
    static func fetchRelativeChannel(query: String,
                                     completion: @escaping (RelativeChannel?,Error?)->()) {
        
        CoreManager.request(type: RelativeChannel.self,
                            url: HomeEndPoint.common.path() + "&q=\(query)") { items, error in
            completion(items,error)
        }
    }
}
