//
//  AutoCompleteTableViewController.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/08.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class AutoCompleteTableViewController: UITableViewController {
    var searchedDummy = [String]()
    deinit {
        SNotification.removeObserver(SearchingTabNotification.SEARCHING_KEYWORD.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SNotification.addObserver(self, selector: #selector(onReceiveData(_:)), name: SearchingTabNotification.SEARCHING_KEYWORD.rawValue, object: nil)
    }
    
    @objc func onReceiveData(_ notification:Notification) {
        guard let keyword = notification.userInfo?["keyword"] as? String else { return }
        print(keyword)
        self.searchedDummy = SearchedHistoryManager.shared.getSimilarityWord(keyword)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedDummy.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autocomplete_cell", for: indexPath) as! AutoCompleteTableViewCell
        cell.setTitle(searchedDummy[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyword = ["keyword" : searchedDummy[indexPath.row]]
        
        SNotification.postNotification(SearchingTabNotification.SEARCHBAR_KEYWORD.rawValue, userInfo: keyword)
    }
    
}
