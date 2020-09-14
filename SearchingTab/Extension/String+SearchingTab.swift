//
//  String+SearchingTab.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/14.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation

extension String {
    init(localized: String) {
        self = NSLocalizedString(localized, comment: localized)
    }
    
    init(localizedFormat: String, args: Any...) {
        self = String(format: String(localized: localizedFormat), args)
    }
}
