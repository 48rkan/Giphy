//
//  CustomTextField.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String,
         secure: Bool = false) {
        super.init(frame: .zero)
        
        textColor = .white
        font = UIFont(name: "Poppins-SemiBold", size: 14)
        
        self.borderStyle = .none
        self.isSecureTextEntry = secure
        
        self.attributedPlaceholder = NSMutableAttributedString(string: placeholder ,attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.4) ,.font: UIFont(name: "OpenSans-Regular", size: 14)])
        self.backgroundColor = UIColor(white: 1, alpha: 0.2)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 10)
        leftView = spacer
        leftViewMode = .always
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}
