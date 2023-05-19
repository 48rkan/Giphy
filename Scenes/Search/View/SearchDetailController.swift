//
//  SearchDetailController.swift
//  Giphy
//
//  Created by Erkan Emir on 19.05.23.
//

import UIKit

class SearchDetailController: UIViewController {
   
    //MARK: - Properties
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(SearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SearchHeader.self)")
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = .red
        return c
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helper
    func configureUI() {
        view.addSubview(collection)
        collection.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

//MARK: - UICollectionViewDelegate

extension SearchDetailController: UICollectionViewDelegate { }

//MARK: - UICollectionViewDataSource
extension SearchDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SearchHeader.self)", for: indexPath) as! SearchHeader
        
        return header
    }
    
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension SearchDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 240)
    }
}
