//  SearchHeader.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import UIKit

class SearchHeader: UICollectionReusableView {
    
    //MARK: - Lifecycle
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
        return cv
    }()
    
    private let giphyClipsTitle = CustomLabel(text: "GIPHY Clips",
                                           textColor: .white,
                                           size: 17,
                                           font: "Poppins-Medium")
    
    private let allGifsTitle = CustomLabel(text: "All the GIFs",
                                           textColor: .white,
                                           size: 17,
                                           font: "Poppins-Medium")

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been")}
    
    func configureUI() {
        addSubview(collection)
        collection.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 4,paddingLeft: 4,paddingRight: 4)
        collection.setHeight(72)
        
        addSubview(giphyClipsTitle)
        giphyClipsTitle.anchor(top: collection.bottomAnchor,left: leftAnchor,paddingTop: 4,paddingLeft: 4)
        
        addSubview(allGifsTitle)
        allGifsTitle.anchor(left: leftAnchor,bottom: bottomAnchor,paddingLeft: 8,paddingBottom: 8)
        
        addSubview(customView)
        customView.anchor(top: giphyClipsTitle.bottomAnchor,left: leftAnchor,bottom: allGifsTitle.topAnchor,right: rightAnchor,paddingTop: 4,paddingLeft: 4,paddingBottom: 4,paddingRight: 4)
        
     
    }
    
    func configure() {
        guard let items = viewModel?.allDatas else { return }
        customView.items = items
        customView.collection.reloadData() // bunu configure funksiyasina cixart
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
        let width = dynamicWidthCalculator(text: (viewModel?.accountDatas[indexPath.row].user?.displayName)!, height: 66) + 132
        
        return CGSize(width: width , height: 66)
    }
}
