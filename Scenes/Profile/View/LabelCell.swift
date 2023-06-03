//  LabelCell.swift
//  Giphy
//  Created by Erkan Emir on 23.05.23.

import UIKit

class LabelCell: UITableViewCell {
    
    var viewModel: LabelCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private lazy var label = CustomLabel(text: "",
                                         textColor: .white,
                                         size: 16, font: "Poppins-Bold")
    
    private let button: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "detail"), for: .normal)
        
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    private func configureUI() {
        backgroundColor = .black
        selectionStyle  = .none
        
        contentView.addSubview(label)
        label.textAlignment = .left
        label.anchor(top: topAnchor,left: leftAnchor,
                     bottom: bottomAnchor,right: rightAnchor,
                     paddingTop: 4,paddingLeft: 4,
                     paddingBottom: 4,paddingRight: 4)
        
        contentView.addSubview(button)
        button.anchor(top: topAnchor,right: rightAnchor,
                      paddingTop: 4,paddingRight: 4)
        button.setDimensions(height: 32, width: 32)
        
    }
    
    private func configure() {
        label.text = viewModel?.item
    }
}
