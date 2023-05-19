//  HomeManager.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation

class HomeManager {
    
    static func fetchGifs(limit: Int,
                          type: GifsType,
                          query: String = "",
                          completion: @escaping (Trending?,Error?)->()) {
        var url = ""
                
        switch type {
        case .trending:
            url = CoreHelper.shared.url(path: "/gifs/trending") + "&limit=\(limit)"
        case .stickers:
            url = CoreHelper.shared.url(path: "/stickers/trending") + "&limit=\(limit)"
        case .emoji:
            url = CoreHelper.shared.url(path: "/emoji") + "&next_cursor=\(limit)"
        case .cats:
            url = CoreHelper.shared.url(path: "/gifs/search") + "&q=\(query)"
        case .dogs:
            url = CoreHelper.shared.url(path: "/gifs/search") + "&q=\(query)"
        case .reactions:
            url = CoreHelper.shared.url(path: "/gifs/search") + "&q=\(query)"
        case .memes:
            url = CoreHelper.shared.url(path: "/gifs/search") + "&q=\(query)"

        }
        
        
        CoreManager.request(type: Trending.self,
                            url: url ) { items, error in
            completion(items,error)
        }
        
    }
    
}
