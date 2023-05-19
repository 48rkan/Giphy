//
//  SearchHeader.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.

import UIKit

class SearchHeader: UICollectionReusableView {
    
    var viewModel: SearchHeaderViewModel? {
        didSet {
            collection.reloadData()
            configure()

        }
    }
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .horizontal, spacing: 4)
        c.backgroundColor = .black
        c.register(LeftImageRightTwoLabelCell.self, forCellWithReuseIdentifier: "\(LeftImageRightTwoLabelCell.self)")
        c.delegate = self
        c.dataSource = self
        return c
    }()
    
    private lazy var customView: HorizontalCollectionInUIView = {
        let cv = HorizontalCollectionInUIView()
            cv.backgroundColor = .green
    //        cv.delegate = self
            return cv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(collection)
        collection.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 4,paddingLeft: 4,paddingRight: 4)
        collection.setHeight(100)
        
        addSubview(customView)
        customView.anchor(top: collection.bottomAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
    }
    
    func configure() {
        guard let items = viewModel?.allDatas else { return }
        customView.items = items
        customView.collection.reloadData()
    }
}

extension SearchHeader: UICollectionViewDelegate { }

extension SearchHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.accountDatas.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(LeftImageRightTwoLabelCell.self)", for: indexPath) as! LeftImageRightTwoLabelCell
        cell.viewModel = LeftImageRightTwoLabelViewModel(items: (viewModel?.accountDatas[indexPath.row])!)
        return cell
    }
    
    
}

extension SearchHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width / 2 - 20, height: 80)
    }
}
