//
//  LeftImageRightTwoLabelViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 20.05.23.
//

import Foundation

class LeftImageRightTwoLabelViewModel {
    var items: Datums
    
    init(items: Datums) {
        self.items = items
    }
    
    var gifURL: URL?  { URL(string: items.user?.avatarURL ?? "")}
    
    var userName: String { items.user?.username ?? "" }
    
    var displayName: String { items.user?.displayName ?? ""}
}
