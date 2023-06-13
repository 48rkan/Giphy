//
//  CustomLabel.swift
//  Giphy
//  Created by Erkan Emir on 14.05.23.

import UIKit

class CustomLabel: UILabel {
    
    init(text     : String,
         textColor: UIColor? = .white,
         hexCode  : String?  = nil,
         size     : CGFloat,
         font     : String   = "Helvetica Neue") {
        super.init(frame: .zero)
        
        if let hexCode = hexCode {
            self.textColor = UIColor(hexString: hexCode)
        } else {
            self.textColor = textColor
        }
        
        self.text = text
        self.font = UIFont(name: font, size: size)
        textAlignment = .center
        numberOfLines = 0
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}
