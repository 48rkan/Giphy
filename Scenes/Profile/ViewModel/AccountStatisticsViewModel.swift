//
//  AccountStatisticsViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 15.06.23.
//

import Foundation

class AccountStatisticsViewModel {
    var accountData: CommonData?
    var favouritedGifsCount: Int
    
    init(accountData: CommonData,favouritedGifsCount: Int) {
        self.accountData = accountData
        self.favouritedGifsCount = favouritedGifsCount
    }
    
    var userName: String       { accountData?.userName     ?? ""}
    var displayName: String    { accountData?.displayName_ ?? ""}
    var profileImageURL: URL?   { URL(string: accountData?.imageURL  ?? "")}
}
