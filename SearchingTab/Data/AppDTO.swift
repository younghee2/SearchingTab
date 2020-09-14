//
//  AppDTO.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation
import ObjectMapper

class AppDTO: BaseDTO {
    
    private(set) var screenshotUrls: [String]?
    private(set) var artworkUrl60: String?
    private(set) var artworkUrl512: String?
    private(set) var artworkUrl100: String?
    private(set) var artistViewUrl: String?
    private(set) var isGameCenterEnabled: Bool?
    private(set) var supportedDevices: [String]?
    private(set) var trackCensoredName: String?
    private(set) var languageCodesISO2A: [String]?
    private(set) var sellerUrl: String?
    private(set) var contentAdvisoryRating: String?
    private(set) var averageUserRating: Double?
    private(set) var releaseNotes: String?
    private(set) var releaseDate: String?
    private(set) var currentVersionReleaseDate: String?
    private(set) var sellerName: String?
    private(set) var userRatingCountForCurrentVersion:Double?
    private(set) var descriptionString: String?
    private(set) var currency: String?
    private(set) var trackName: String?
    private(set) var trackId: Int?
    private(set) var trackViewUrl: String?
    private(set) var bundleId: String?
    private(set) var version: String?
    private(set) var genres: [String]?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        screenshotUrls <- map["screenshotUrls"]
        artworkUrl60 <- map["artworkUrl60"]
        artworkUrl512 <- map["artworkUrl512"]
        artworkUrl100 <- map["artworkUrl100"]
        artistViewUrl <- map["artistViewUrl"]
        isGameCenterEnabled <- map["isGameCenterEnabled"]
        supportedDevices <- map["supportedDevices"]
        trackCensoredName <- map["trackCensoredName"]
        languageCodesISO2A <- map["languageCodesISO2A"]
        sellerUrl <- map["sellerUrl"]
        contentAdvisoryRating <- map["contentAdvisoryRating"]
        averageUserRating <- map["averageUserRating"]
        releaseNotes <- map["releaseNotes"]
        currentVersionReleaseDate <- map["currentVersionReleaseDate"]
        userRatingCountForCurrentVersion <- map["userRatingCountForCurrentVersion"]
        sellerName <- map["sellerName"]
        descriptionString <- map["description"]
        currency <- map["currency"]
        trackName <- map["trackName"]
        bundleId <- map["bundleId"]
        version <- map["version"]
        genres <- map["genres"]
        releaseDate <- map["releaseDate"]
        trackViewUrl <- map["trackViewUrl"]
        trackId <- map["trackId"]
    }
    
}
