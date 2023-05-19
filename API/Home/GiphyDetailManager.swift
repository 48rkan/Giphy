//  GiphyDetailManager.swift
//  Giphy
//  Created by Erkan Emir on 17.05.23.

import Foundation

class GiphyDetailManager {
    static func fetchRelatedGifs(query: String,
                                 completion: @escaping (Trending?,Error?)->()) {
        
        CoreManager.request(type: Trending.self,
                            url: CoreHelper.shared.url(path: "/gifs/search") + "&q=\(query)") { items, error in
            completion(items,error)
        }
    }
}
