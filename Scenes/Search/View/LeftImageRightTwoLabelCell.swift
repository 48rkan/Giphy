//  LeftImageRightTwoLabelCell.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import UIKit

class LeftImageRightTwoLabelCell: UICollectionViewCell {
    
    var viewModel: LeftImageRightTwoLabelViewModel? {
        didSet {
            configure()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = Color.darkPink.color()
        return iv
    }()
    
    private let userNameLabel = CustomLabel(text: "GIPHY Clips",
                                            textColor: .white,
                                            size: 17,
                                            font: Font.pMedium.rawValue)
    
    private let displayNameLabel = CustomLabel(text: "GIPHY Clips",
                                               hexCode: Color.ashGrey.rawValue,
                                               size: 12,
                                               font: Font.pExtraLight.rawValue)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configureUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been")}
    
    func configureUI() {
        addSubview(imageView)
        imageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 4)
        imageView.setDimensions(height: 48, width: 48)
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel,displayNameLabel])
        addSubview(stack)
        userNameLabel.numberOfLines = 0
        displayNameLabel.numberOfLines = 0
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        
        stack.anchor(top: topAnchor,left: imageView.rightAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 12,paddingLeft: 4,paddingBottom: 12,paddingRight: 0)
    }
    
    func configure() {
        guard let gifUrl = viewModel?.gifURL else { return }
        setGifFromURL(imageView: imageView, url: gifUrl)
        userNameLabel.text = viewModel?.userName
        displayNameLabel.text = viewModel?.displayName
    }
}
