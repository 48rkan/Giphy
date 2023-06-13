//
//  CustomButton.swift
//  Giphy
//
//  Created by Erkan Emir on 07.06.23.
//

import UIKit

class CustomButton: UIButton {
    
    //MARK: - Lifecycle
    init(title     : String,
         titleColor: UIColor,
         font      : String  = "Poppins-Bold",
         size      : CGFloat = 16 ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont(name: font, size: size)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
}

