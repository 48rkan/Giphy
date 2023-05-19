//  GiphyCellViewModel.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import Foundation

class GiphyCellViewModel {
    var items: CommonData
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL : URL? { URL(string: items.gifURL ?? "") }
}
