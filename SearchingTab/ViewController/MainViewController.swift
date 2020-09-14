//
//  MainViewController.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var autoCompleteView: UIView!
    
    @IBOutlet weak var navagationItem: UINavigationItem!
    
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var searchResultView: UIView!
    private var searchBar = UISearchController(searchResultsController: nil)
    
    deinit {
        SNotification.removeObserver(SearchingTabNotification.SEARCHBAR_KEYWORD.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBar.placeholder = String(localized: "searchbar_default_msg")
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.obscuresBackgroundDuringPresentation = false
        SNotification.addObserver(self, selector: #selector(onReceiveData(_:)), name: SearchingTabNotification.SEARCHBAR_KEYWORD.rawValue, object: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    @objc func onReceiveData(_ notification:Notification) {
        //최근검색어에서 SEARCH_KEYWORD 전송 / keyword 검색탭 세팅 및 검색결과 이동
        guard let keyword = notification.userInfo?["keyword"] as? String else { return }
        searchBar.isActive = true
        searchBar.searchBar.text = keyword
        self.searchBarSearchButtonClicked(searchBar.searchBar)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SearchedHistoryManager.shared.setSearchedWord(searchBar.text ?? "")
        let keyword = ["keyword" : searchBar.text ?? ""]
        SNotification.postNotification(SearchingTabNotification.SEARCH_KEYWORD.rawValue, userInfo: keyword)
        searchResultView.isHidden = false
        historyView.isHidden = true
        autoCompleteView.isHidden = true
        self.view.endEditing(true)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        historyView.isHidden = false
        autoCompleteView.isHidden = true
        searchResultView.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if autoCompleteView.isHidden {
            autoCompleteView.isHidden = false
            historyView.isHidden = true
            searchResultView.isHidden = true
        }
        let keyword = ["keyword" : searchText ]
        SNotification.postNotification(SearchingTabNotification.SEARCHING_KEYWORD.rawValue, userInfo: keyword)
    }
    
}
