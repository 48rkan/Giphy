//
//  Font.swift
//  Giphy
//
//  Created by Erkan Emir on 15.06.23.
//

import UIKit

enum Font: String {
    case pBold            = "Poppins-Bold"
    case pSemiBold        = "Poppins-SemiBold"
    case pMedium          = "Poppins-Medium"
    case pLight           = "Poppins-Light"
    case pExtraLight      = "Poppins-ExtraLight"
    
    func font(size: CGFloat) -> UIFont {
        UIFont(name: self.rawValue, size: size) ?? UIFont()
    }
}
