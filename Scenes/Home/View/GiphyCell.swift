//  GiphyCell.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import UIKit

class GiphyCell: UICollectionViewCell {
    
    var viewModel: GiphyCellViewModel? {
        didSet {
            configure()
        }
    }
    
    //MARK: - Properties
    private let gifView: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = Color.darkPink.color()
        
        return v
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifView.image = nil
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helper
    func configureUI() {
        addSubview(gifView)
        gifView.anchor(top: topAnchor,left: leftAnchor,
                       bottom: bottomAnchor,right: rightAnchor,
                       paddingTop: 4,paddingLeft: 4,
                       paddingBottom: 4,paddingRight: 4)
    }
    
    func configure() {
        guard let url = viewModel?.gifURL else { return }
        setGifFromURL(imageView: gifView, url: url)
    }
}
