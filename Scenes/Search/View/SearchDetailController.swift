//  SearchDetailController.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import UIKit

class SearchDetailController: UIViewController {
   
    //MARK: - Properties
    var coordinator: AppCoordinator?
    
    var viewModel: SearchDetailViewModel? {
        didSet {
            collection.reloadData()
        }
    }
    
    private lazy var searchView: CustomSearchView = {
        let iv = CustomSearchView()
        iv.delegate = self
        return iv
    }()
    
    private lazy var collection: CustomCollectionView = {
        let c = CustomCollectionView(scroll: .vertical, spacing: 4)
        c.register(SearchHeader.self,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                   withReuseIdentifier: "\(SearchHeader.self)")
        c.register(GiphyCell.self, forCellWithReuseIdentifier: "\(GiphyCell.self)")
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = .black
        return c
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        guard let viewModel else { return }
        viewModel.fetchMatchesGifs(text: viewModel.text)
        viewModel.fetchRelativeChannel(query: viewModel.text)
        
        viewModel.succesCallBack = {
            self.collection.reloadData()
            self.showLoader(false)
        }
        
        guard let nav = navigationController else { return }
        coordinator = AppCoordinator(navigationController: nav)
    }
        
    //MARK: - Helper
    func configureUI() {
        view.addSubview(searchView)
        searchView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,right: view.rightAnchor)
        searchView.setHeight(48)
        view.addSubview(collection)
        collection.anchor(top: searchView.bottomAnchor,left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,
                          paddingBottom: 0,paddingRight: 0)
    }
}

//MARK: - UICollectionViewDelegate

extension SearchDetailController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        coordinator?.showGiphyDetail(items: viewModel.items[indexPath.row])
    }
}

//MARK: - UICollectionViewDataSource
extension SearchDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else { return UICollectionViewCell()}
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(GiphyCell.self)", for: indexPath) as! GiphyCell
        cell.viewModel = GiphyCellViewModel(items: viewModel.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewModel = viewModel else { return  UICollectionReusableView() }
        
        let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SearchHeader.self)", for: indexPath) as! SearchHeader
        header.delegate  = self
        header.viewModel = SearchHeaderViewModel(accountDatas: viewModel.accountDatas, allDatas: viewModel.items )
        return header
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension SearchDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2 - 2 , height: 100)
    }
}

//MARK: - SearchHeaderDelegate
extension SearchDetailController: SearchHeaderDelegate {
    func header(_ header: SearchHeader, wantsToShowDetail data: CommonData) {
        coordinator?.showGiphyDetail(items: data)
    }
    
    func header(_ header: SearchHeader, wantsToShowAccount data: Datums) {
        coordinator?.showAccount(items: data, type: .other)
    }
}

//MARK: - CustomSearchViewDelegate
extension SearchDetailController: CustomSearchViewDelegate {
    func view(_ searchView: CustomSearchView, editingChangedTextField text: String) {
        viewModel?.text = text
    }
    
    func searchIconClicked(_ view: CustomSearchView) {
        guard let viewModel else { return }

        viewModel.fetchMatchesGifs(text: viewModel.text)
        viewModel.fetchRelativeChannel(query: viewModel.text)
        self.collection.reloadData()
        showLoader(true)
    }
}
