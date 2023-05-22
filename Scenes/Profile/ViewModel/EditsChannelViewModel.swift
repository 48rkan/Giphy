//
//  EditsChannelViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 22.05.23.
//

import Foundation

class EditsChannelViewModel {
    var items: CommonData
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL: URL? { URL(string: items.gifURL_ ?? "")}
    
    var userName: String { items.userName ?? ""}
}
