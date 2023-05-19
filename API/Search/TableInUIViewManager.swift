//  TableInUIViewManager.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import Foundation

class TableInUIViewManager {
    static func fetchRelatedTags(tags: String,
                                 completion: @escaping (RelativeSuggestion?,Error?)->()) {
        
        CoreManager.request(type: RelativeSuggestion.self,
                            url: CoreHelper.shared.url(path: "/related/\(tags)") + "&term=\(tags)",method: .get) { items, error in
            print(CoreHelper.shared.url(path: "/tags/related/<\(tags)>") + "&term=\(tags)")
            completion(items,error)
            print(error?.localizedDescription)
        }
    }
}
