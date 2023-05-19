//
//  LeftImageRightTwoLabelCell.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import UIKit

class LeftImageRightTwoLabelCell: UICollectionViewCell {
    
    var viewModel: LeftImageRightTwoLabelViewModel? {
        didSet {
            configure()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        
        return iv
    }()
    
    private let userNameLabel = CustomLabel(text: "MotoGP",
                                            size: 14)
    
    private let displayNameLabel = CustomLabel(text: "@motoGP",
                                               size: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        configureUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been ")}
    
    func configureUI() {
        addSubview(imageView)
        imageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 4)
        imageView.setDimensions(height: 48, width: 48)
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel,displayNameLabel])
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.centerY(inView: imageView,leftAnchor: imageView.rightAnchor,paddingLeft: 4)
        stack.anchor(right: rightAnchor,paddingRight: 4)
    }
    
    func configure() {
        guard let gifUrl = viewModel?.gifURL else { return }
        imageView.setGifFromURL(gifUrl, showLoader: true)
        userNameLabel.text = viewModel?.userName
        displayNameLabel.text = viewModel?.displayName
        
    }
}
