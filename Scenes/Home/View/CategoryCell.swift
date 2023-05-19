//  AnyCell.swift
//  Giphy
//  Created by Erkan Emir on 15.05.23.

import UIKit

class CategoryCell: UICollectionViewCell {
    
    var viewModel: CategoryCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let title = CustomLabel(text: "",
                                              hexCode: "#e5e5e5",
                                              size: 16,
                                              font: "Poppins-SemiBold")
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#333333")
        layer.cornerRadius = 12
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    private func configureUI() {
        addSubview(title)
        title.centerX(inView: self)
        title.centerY(inView: self)
    }
    
    func configure() {
        self.title.text = viewModel?.items
    }
}
