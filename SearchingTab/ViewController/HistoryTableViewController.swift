//
//  HistoryTableViewController.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var searchedList = [String]()
    
    deinit {
        SNotification.removeObserver(SearchingTabNotification.SEARCH_KEYWORD.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        header.backgroundColor = .white
        
        let headerText = UILabel(frame: header.bounds)
        headerText.text = String(localized: "recently_search_keyword")
        headerText.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        headerText.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(headerText)
        
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: header.topAnchor, constant: 10),
            headerText.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            headerText.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: 10)
        ])
        
        self.tableView.tableHeaderView = header
        self.searchedList = SearchedHistoryManager.shared.getSearchedHistoryList()
        self.tableView.reloadData()
        SNotification.addObserver(self, selector: #selector(onReceiveData(_:)), name: SearchingTabNotification.SEARCH_KEYWORD.rawValue, object: nil)
    }
    
    @objc func onReceiveData(_ notification:Notification) {
        self.searchedList = SearchedHistoryManager.shared.getSearchedHistoryList()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history_cell", for: indexPath) as? HistoryTableViewCell
        cell?.setKeyword(searchedList[indexPath.row])
        return cell ?? HistoryTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = ["keyword" : searchedList[indexPath.row]]
        SNotification.postNotification(SearchingTabNotification.SEARCHBAR_KEYWORD.rawValue, userInfo: keyword)
    }
}
