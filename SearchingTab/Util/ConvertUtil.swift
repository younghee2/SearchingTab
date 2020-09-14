//
//  ConvertUtil.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/13.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation

enum DateUnit {
    case Day
    case Minute
    case Second
}

class ConvertUtil {

    static func convertDateStringToDate(string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
    
    /**
        현재기준 source 시간 차이 계산(일-->시간 순서로)
     */
    static func getDayCountFromCurrent(value:String) -> String {
        if let data = ConvertUtil.convertDateStringToDate(string: value) {
            return compareDate(source: data, dest: Date())
        }
        return ""
    }

    static func compareDate(source: Date, dest: Date) -> String {
        var delta: Int?
        var compareDateString:String = ""
            delta = Calendar.current.dateComponents([.day], from: source, to: dest).day ?? 0
            if (delta ?? 0) < 1 {
                delta = Calendar.current.dateComponents([.hour], from: source, to: dest).hour
                compareDateString = String(delta ?? 0).appending(String(localized: "before_hour"))
            } else {
                compareDateString = String(delta ?? 0).appending(String(localized: "before_day"))
            }
        return compareDateString
    }
    
    /**
        리뷰수 계산(만, 천, 이하 단위)
    */
    static func userRatingCount(_ point: Double) -> String {
        let printedPoint = point / 1000
        var returnString = ""
        if printedPoint > 10 {
            //만단위
            returnString = String(format: "%.1f", printedPoint / 10).appending(String(localized: "ten_thousand"))
        } else if(printedPoint < 1){
            returnString = String(format: "%.0f", point)
        } else {
            //천단위
            returnString = String(format: "%.1f", printedPoint).appending(String(localized: "thousand"))
        }
        return returnString
    }
    
}
