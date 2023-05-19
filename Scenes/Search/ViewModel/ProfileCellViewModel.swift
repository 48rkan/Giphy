//
//  ProfileCellViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import Foundation

class ProfileCellViewModel {
    var items: Datums
    
    init(items: Datums) {
        self.items = items
    }
    
    var profilePhotoURL: URL? { URL(string: items.user?.avatarURL ?? "") }
    
    var username: String { items.user?.username ?? ""}
    
    var displayName: String { items.displayName ?? "" }
}
