//  Account.swift
//  Giphy
//  Created by Erkan Emir on 21.05.23.

import Foundation

struct Account {
    var email      : String
    var username   : String
    var profilimage: String
    var uid        : String
    var banner     : String
    
    init(dictionary: [String:Any]) {
        self.email       = dictionary["email"]    as? String ?? ""
        self.username    = dictionary["username"] as? String ?? ""
        self.profilimage = dictionary["gif"]      as? String ?? ""
        self.uid         = dictionary["uid"]      as? String ?? ""
        self.banner      = dictionary["banner"]   as? String ?? ""
    }
}

extension Account: CommonData {
    
    var gifID_      : String? { nil }
    var gifURL_     : String? { profilimage }
    var imageURL    : String? { profilimage }
    var userName    : String? { username }
    var bannerURL   : String? { banner   }
    var displayName_: String? { username }
}
