//
//  SearchDetailController.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import UIKit

class SearchDetailController: UIViewController {
   
    //MARK: - Properties
    
    var viewModel: SearchDetailViewModel? {
        didSet {
            configure()
            collection.reloadData()
        }
    }
    
    private lazy var searchView: CustomSearchView = {
        let iv = CustomSearchView()
//        iv.delegate = self
        return iv
    }()
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SearchHeader.self)")
        c.register(GiphyCell.self, forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = .red
        return c
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel?.fetchMatchesGifs()
        viewModel?.succesCallBack = { self.collection.reloadData()}
    }
    
    func configure() { }
    
    //MARK: - Helper
    func configureUI() {
        view.addSubview(searchView)
        searchView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        searchView.setHeight(48)
        view.addSubview(collection)
        collection.anchor(top: searchView.bottomAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

//MARK: - UICollectionViewDelegate

extension SearchDetailController: UICollectionViewDelegate { }

//MARK: - UICollectionViewDataSource
extension SearchDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else { return  UICollectionReusableView()}
        
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SearchHeader.self)", for: indexPath) as! SearchHeader
        header.viewModel = SearchHeaderViewModel(accountDatas: viewModel.accountDatas,allDatas: viewModel.items )
        return header
    }
    
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension SearchDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 20)
    }
}
