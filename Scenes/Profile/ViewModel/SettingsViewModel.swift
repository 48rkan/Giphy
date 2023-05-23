//
//  SettingsViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 22.05.23.
//

import Foundation

class SettingsViewModel {
    
    var tableTitles = ["Account Settings", "Set Up Keyboard", "Support" , "Privacy & Safety", "Rate the App" , "Acknowledgements"]
    
    var items: CommonData
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL  : URL?   { URL(string: items.gifURL_ ?? "") }
    var userName: String { items.userName ?? "" }
}
