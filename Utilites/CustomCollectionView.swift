//  CustomCollectionView.swift
//  Giphy
//  Created by Erkan Emir on 15.05.23.

import UIKit

class CustomCollectionView: UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    
    init(scroll: UICollectionView.ScrollDirection,
         spacing: CGFloat) {
        super.init(frame: .zero,
                   collectionViewLayout: layout)
        layout.scrollDirection = scroll
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureCollectionView() {
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
}
