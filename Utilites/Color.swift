//
//  Fonts.swift
//  Giphy
//
//  Created by Erkan Emir on 15.06.23.
//

import UIKit

enum Color: String {
    case sealBrown            = "#1B1212"
    case midnightBlue         = "#6a18ff"
    case darkPink             = "8050D7"
    case gray                 = "#e5e5e5"
    case darkCharcoal         = "#333333"
    case nero                 = "#191919"
    case ashGrey              = "#B2BEB5"
    case eggshell             = "#F0EAD6"
    case lunarGreen           = "#353935"

    func color() -> UIColor {
        UIColor(hexString: self.rawValue)
    }
}
