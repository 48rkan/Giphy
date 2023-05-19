//
//  SearchControllerInUIView.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import Foundation


import UIKit
//
//protocol CustomViewDelegate: AnyObject {
//    func category(_ name: String)
//}

class HorizontalCollectionInUIView: UIView {
    
    //MARK: - Properties
    var items = [CommonData]()
        
    weak var delegate: CustomViewDelegate?
    
    lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .horizontal, spacing: 4)
        c.register(GiphyCell.self, forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.backgroundColor = UIColor(hexString: "#191919")
        c.delegate   = self
        c.dataSource = self
        return c
    }()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    //MARK: - Helper

    private func configureUI() {
        addSubview(collection)
        collection.anchor(top: topAnchor,left: leftAnchor,
                          bottom: bottomAnchor,right: rightAnchor,
                          paddingTop: 4,paddingLeft: 4,
                          paddingBottom: 4,paddingRight: 4)
        
    }
}

extension HorizontalCollectionInUIView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
//        delegate?.category(array[indexPath.item])
    }
}

extension HorizontalCollectionInUIView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        cell.viewModel = GiphyCellViewModel(items: items[indexPath.row])
        return cell
    }
}

extension HorizontalCollectionInUIView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
