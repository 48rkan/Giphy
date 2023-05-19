//  GiphyDetailHeader.swift
//  Giphy
//  Created by Erkan Emir on 18.05.23.

import UIKit

class GiphyDetailHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK:- Helpers
    func configureUI() {
        self.backgroundColor = .red
    }
}
