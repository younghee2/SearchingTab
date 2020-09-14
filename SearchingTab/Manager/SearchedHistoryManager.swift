//
//  SearchedHistoryManager.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/11.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation


class SearchedHistoryManager: NSObject {
    let SEARCHED_HISTORY = "SEARCHED_HISTORY"
    static let shared = SearchedHistoryManager()
    
    private var searchedList = Array<String>()
    
    fileprivate override init() {
        super.init()
        if let savedSearchedList = UserDefaults.standard.array(forKey: SEARCHED_HISTORY) as? Array<String> {
            self.searchedList = savedSearchedList
        }
    }
    
    func getSimilarityWord(_ keyword:String) -> [String] {
        let sorted = searchedList.sorted { element1, element2 in
            return element1.contains(keyword) && !element2.contains(keyword)
        }
        return sorted
    }
    
    func setSearchedWord(_ keyword: String) {
        /**
         이전에 검색했던 이력이 있는경우 삭제하고 맨위로 올려줘야함
         */
        if searchedList.contains(keyword) {
            for (index, beforeKeyword) in searchedList.enumerated() {
                if keyword == beforeKeyword {
                    searchedList.remove(at: index)
                    break
                }
            }
        }
        searchedList.append(keyword)
        UserDefaults.standard.set(searchedList, forKey: SEARCHED_HISTORY)
        UserDefaults.standard.synchronize()
    }
    
    func getSearchedHistoryList() -> [String]{
        return searchedList.reversed()
    }
    
    
}
