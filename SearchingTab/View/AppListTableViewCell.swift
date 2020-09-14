//
//  AppListTableViewCell.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class AppListTableViewCell: UITableViewCell {
    @IBOutlet weak var ivAppIcon: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var userRatingCount: UILabel!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var ivFirstSample: UIImageView!
    @IBOutlet weak var ivSecondSample: UIImageView!
    @IBOutlet weak var ivThirdSample: UIImageView!
    @IBOutlet weak var starRating: UIStackView!
    
    @IBOutlet weak var thumbStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(appInfo: AppDTO) {
        self.ivAppIcon.load(url: appInfo.artworkUrl512 ?? "")
        self.trackName.text = appInfo.trackName
        self.sellerName.text = appInfo.sellerName
        self.userRatingCount.text = ConvertUtil.userRatingCount(appInfo.userRatingCountForCurrentVersion ?? 0)
        self.starRating.starRating(score:appInfo.averageUserRating ?? 0)
        
        for (index, element) in (appInfo.screenshotUrls ?? [String]()).enumerated() {
            let imageView = self.thumbStackView.subviews[index] as? UIImageView
            imageView?.load(url: element)
            if index == 2 {
                break
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
