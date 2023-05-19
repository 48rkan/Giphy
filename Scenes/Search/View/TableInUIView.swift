//  TableInUIView.swift
//  Giphy
//  Created by Erkan Emir on 19.05.23.

import UIKit

class TableInUIView: UIView {
    
    //MARK: - Properties
    
    var viewModel = TableInUIViewModel()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.register(SuggestionCell.self, forCellReuseIdentifier: "\(SuggestionCell.self)")
        t.delegate   = self
        t.dataSource = self
        t.rowHeight = 24
        t.backgroundColor = .white
        
        return t
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been") }
    
    func configureUI() {
        addSubview(table)
        table.anchor(top: topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingTop: 0,paddingLeft: 0,paddingBottom: 0,paddingRight: 0)
    }
}

extension TableInUIView: UITableViewDelegate { }

extension TableInUIView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(SuggestionCell.self)") as! SuggestionCell
        
        return cell
    }
    
    
}
