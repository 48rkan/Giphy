//  Account.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation

struct Account {
    var email: String
    var username: String
    var profilimage: String
    var uid: String
    var banner: String
}

extension Account: CommonData {
    var isFavourite: Bool? { false }
    
    var gifID_: String? { "" }
    var gifURL_: String? { profilimage }
    var imageURL: String? { profilimage }
    var userName: String? { username }
    var bannerURL: String? { banner }
    var displayName_: String? { username }
}
