//
//  BaseDTO.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation
import ObjectMapper

open class BaseDTO: NSObject, Mappable {
    
    public required init?(map: Map) {

    }
    
    open func mapping(map: Map) {
        
    }
    
    open func compare<T: BaseDTO>(compareDTO: T) -> Int64 {
        return 0
    }
    
}
