//  TableInUIViewManager.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class TableInUIViewManager {
    static func fetchRelatedTags(tags: String,
                                 completion: @escaping (RelativeSuggestion?,Error?)->()) {
        
        let url = CoreHelper.shared.url(path: "/tags/related/\(tags)") + "&term=\(tags)"
        CoreManager.request(type: RelativeSuggestion.self,
                            url: url,
                            method: .get) { items, error in
            completion(items,error)
            print(error?.localizedDescription)
        }
    }
}
