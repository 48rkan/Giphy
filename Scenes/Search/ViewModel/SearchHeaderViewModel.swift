//
//  SearchHeaderViewModel.swift
//  Giphy
//
//  Created by Erkan Emir on 20.05.23.
//

import Foundation

class SearchHeaderViewModel {
    var accountDatas: [Datums]
    var allDatas: [Datum]
    
    init(accountDatas: [Datums],allDatas:[Datum]) {
        self.accountDatas = accountDatas
        self.allDatas = allDatas
    }
}
