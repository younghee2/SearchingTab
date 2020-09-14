//
//  SNotification.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation

enum SearchingTabNotification: String {
    case SearchingKeyword = "searchingKeyword"
    case SEARCH_KEYWORD = "SEARCH_KEYWORD"
    case SEARCHBAR_KEYWORD = "SEARCHBAR_KEYWORD"
    case SEARCHING_KEYWORD = "SEARCHING_KEYWORD"
}

class SNotification {
    
    static func addObserver(_ observer:Any, selector aSelector: Selector, name action: String, object anObject: Any?) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: NSNotification.Name(rawValue: action), object: anObject)
    }
    
    static func removeObserver(_ observer: Any) {
          NotificationCenter.default.removeObserver(observer)
    }
    
    static func postNotification(_ action: String, userInfo: [AnyHashable : Any]?) {
        print("SNotification Post : \(action) / info: \(String(describing: userInfo?.description))")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: action), object: self, userInfo: userInfo)
        }
    }
}
