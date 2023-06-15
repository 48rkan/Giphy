//  CustomView.swift
//  Giphy
//  Created by Erkan Emir on 16.05.23.

import UIKit

protocol CustomViewDelegate: AnyObject {
    func category(_ name: String)
}

class CollectionInUIView: UIView {
    
    //MARK: - Properties
    
    var array = [ "Trending", "Stickers", "Emoji", "Reactions", "Memes", "Cats", "Dogs" ]
    
    weak var delegate: CustomViewDelegate?
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .horizontal, spacing: 4)
        c.register(CategoryCell.self, forCellWithReuseIdentifier: "\(CategoryCell.self)")
        c.backgroundColor = Color.nero.color()
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

extension CollectionInUIView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        delegate?.category(array[indexPath.item])
    }
}

extension CollectionInUIView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
        cell.viewModel =  CategoryCellViewModel(items: array[indexPath.row])
        return cell
    }
}

extension CollectionInUIView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dynamicWidthCalculator(text: array[indexPath.row], height: 40) + 32
        return CGSize(width: width, height: 36)
    }
}
