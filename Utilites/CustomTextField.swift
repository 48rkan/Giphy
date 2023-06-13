//
//  CustomTextField.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String,
         fontName   : String  = "Poppins-SemiBold",
         size       : CGFloat = 14,
         textColor  : UIColor = .white,
         secure     : Bool    = false) {
        super.init(frame: .zero)
        
        self.textColor = textColor
        self.font      = UIFont(name: fontName, size: size)
        
        self.borderStyle       = .none
        self.isSecureTextEntry = secure
        
        self.attributedPlaceholder = NSMutableAttributedString(
            string: placeholder ,
            attributes:
                [.foregroundColor: UIColor(white: 1, alpha: 0.4),
                 .font: font ?? UIFont()
                ])
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.2)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 10)
        leftView     = spacer
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}
