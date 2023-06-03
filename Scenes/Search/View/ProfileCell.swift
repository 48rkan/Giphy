//  ProfileCell.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import UIKit

class ProfileCell: UITableViewCell {
    
    var viewModel: ProfileCellViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profilImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "8050D7")
        return iv
    }()
    
    private let userNameLabel = CustomLabel(text: "MotoGP",
                                            size: 14)
    
    private let displayNameLabel = CustomLabel(text: "@motoGP",
                                               size: 14)
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI() {
        contentView.addSubview(profilImage)
        profilImage.centerY(inView: self,leftAnchor: contentView.leftAnchor,paddingLeft: 8)
        profilImage.setDimensions(height: 48, width: 48)
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel,displayNameLabel])
        contentView.addSubview(stack)
        stack.centerY(inView: profilImage,
                      leftAnchor: profilImage.rightAnchor
                      ,paddingLeft: 8)
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
    }
    
    func configure() {
        guard let profileURL = viewModel?.profilePhotoURL else { return }
        setGifFromURL(imageView: profilImage, url: profileURL)
        userNameLabel.text = viewModel?.username
        displayNameLabel.text = viewModel?.displayName
    }
    
}
