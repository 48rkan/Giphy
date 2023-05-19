//
//  SuggestionCell.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23

import UIKit

class SuggestionCell: UITableViewCell {
    
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
//        iv.image = UIImage(named: "search")
        
        return iv
    }()
    
    private let userNameLabel = CustomLabel(text: "username",
                                            size: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI() {
        contentView.addSubview(icon)
        icon.centerY(inView: self,leftAnchor: contentView.leftAnchor,paddingLeft: 8)
        icon.setDimensions(height: 24, width: 24)
        
        contentView.addSubview(userNameLabel)
        userNameLabel.textColor = .black
        userNameLabel.centerY(inView: contentView,leftAnchor: icon.rightAnchor,paddingLeft: 4)
    }
}
