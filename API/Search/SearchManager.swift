//  SearchManager.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class SearchManager {
    static func fetchRelativeChannel(query: String,completion: @escaping (RelativeChannel?,Error?)->()) {
        CoreManager.request(type: RelativeChannel.self, url: CoreHelper.shared.url(path: "/channels/search") + "&q=\(query)") { items, error in
            print(CoreHelper.shared.url(path: "/channels/search") + "&q=\(query)")
            completion(items,error)
        }
    }
}
