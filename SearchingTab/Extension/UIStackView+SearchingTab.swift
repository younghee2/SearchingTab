//
//  UIStackView+SearchingTab.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/14.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

extension UIStackView {
    func starRating(score:Double) {
        var totalScore:Double = score
        for star in self.subviews {
            let starImageView = star as? UIImageView
            if totalScore >= 1 {
                starImageView?.image = UIImage(systemName: "star.fill")
            } else if totalScore >= 0.5 {
                starImageView?.image = UIImage(systemName: "star.lefthalf.fill")
            } else {
                starImageView?.image = UIImage(systemName: "star")
            }
            totalScore -= 1
        }
    }
}
