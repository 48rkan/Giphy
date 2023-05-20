//  SearchController.swift
//  Giphy
//  Created by Erkan Emir on 13.05.23.

import UIKit
import SwiftyGif

class SearchController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    private lazy var searchView: CustomSearchView = {
        let iv = CustomSearchView()
        iv.delegate = self
        return iv
    }()
    
//    private lazy var tableInUIView: TableInUIView = {
//        let tv = TableInUIView()
//
//        return tv
//    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.register(ProfileCell.self, forCellReuseIdentifier: "\(ProfileCell.self)")
        t.delegate   = self
        t.dataSource = self
        t.rowHeight = 56
        t.backgroundColor = .black
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel.successCallBack = { self.table.reloadData() }
    }
    
    func configureUI() {
        view.addSubview(searchView)
        searchView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        searchView.setHeight(48)
        
//        view.addSubview(tableInUIView)
//        tableInUIView.anchor(top: searchView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingRight: 0)
//        tableInUIView.setHeight(80)
        view.addSubview(table)
        table.anchor(top: searchView.bottomAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AccountController()
        controller.viewModel = AccountViewModel(items: viewModel.items[indexPath.row])
        navigationController?.show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if !viewModel.items.isEmpty  {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0,
                                                            width: tableView.frame.width,
                                                            height: 50))
            headerView.backgroundColor = .black
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5,
                                      width: headerView.frame.width - 10,
                                      height: headerView.frame.height - 10)
            label.text = "Channels"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .white
            
            headerView.addSubview(label)
            
            return headerView

        }
        return UIView()
        }
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(ProfileCell.self)") as! ProfileCell
        cell.viewModel = ProfileCellViewModel(items: viewModel.items[indexPath.row])
        return cell
    }
}

//MARK: - CustomSearchViewDelegate

extension SearchController: CustomSearchViewDelegate {
    func view(_ searchView: CustomSearchView, editingChangedTextField text: String) {
        viewModel.currentText = text
        viewModel.fetchRelativeChannel(query: text)
        viewModel.fetchRelatedTags(tags: text)
    }
    
    func searchIconClicked(_ view: CustomSearchView) {
//        print(view.backgroundColor)
        let controller = SearchDetailController()
        controller.viewModel = SearchDetailViewModel(items: viewModel.items)
        controller.viewModel?.text = viewModel.currentText
        navigationController?.show(controller, sender: nil)
    }
}
