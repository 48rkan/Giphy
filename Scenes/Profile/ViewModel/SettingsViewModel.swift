//  SettingsViewModel.swift
//  Giphy
//  Created by Erkan Emir on 22.05.23.

import Foundation

class SettingsViewModel {
    
    var items: CommonData
    
    var tableTitles: [Settings] =  [
        .init(title: "Account Settings", type: .account),
        .init(title: "Send Email" , type: .email),
        .init(title: "Support"         , type: .support),
        .init(title: "Privacy & Safety", type: .privacy),
        .init(title: "Rate the App"    , type: .rateTheApp),
        .init(title: "Acknowledgements", type: .acknowLedgements)
    ]
    
    init(items: CommonData) {
        self.items = items
    }
    
    var gifURL  : URL?   { URL(string: items.gifURL_ ?? "") }
    var userName: String { items.userName ?? "" }
    
}
