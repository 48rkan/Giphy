//  HomeManager.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation

class HomeManager: HomeManagerProtocol {
    
    static func fetchGifs(limit: Int,
                          type: GifsType,
                          query: String = "",
                          completion: @escaping (Trending?, Error?)->()) {
        var url = ""
                
        switch type {
        case .trending : url = HomeEndPoint.trending.path() + "&limit=\(limit)"
        case .stickers : url = HomeEndPoint.stickers.path() + "&limit=\(limit)"
        case .emoji    : url = HomeEndPoint.emoji.path()    + "&limit=\(limit)"
        case .cats     : url = HomeEndPoint.common.path()   + "&q=\(query)"
        case .dogs     : url = HomeEndPoint.common.path()   + "&q=\(query)"
        case .reactions: url = HomeEndPoint.common.path()   + "&q=\(query)"
        case .memes    : url = HomeEndPoint.common.path()   + "&q=\(query)"
        case .none     : break
        }
        
        CoreManager.request(type: Trending.self,
                            url: url ) { items, error in
            completion(items,error)
        }
    }
    
    static func fetchRelatedGifs(query: String,
                                 completion: @escaping (Trending?, Error?)->()) {
        CoreManager.request(type: Trending.self,
                            url: HomeEndPoint.common.path() + "&q=\(query)") { items, error in
            completion(items,error)
        }
    }
}
