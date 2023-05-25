//
//  SettingsModel.swift
//  Giphy
//
//  Created by Erkan Emir on 25.05.23.
//

import Foundation

enum SettingsType {
    case account
    case email
    case support
    case privacy
    case rateTheApp
    case acknowLedgements
}

struct Settings {
    var title: String
    var type: SettingsType
}
