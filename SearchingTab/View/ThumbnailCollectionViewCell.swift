//
//  ThumbnailCollectionViewCell.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/14.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var screenshotImage: UIImageView!
    

    func setImage(_ imageUrl:String) {
        screenshotImage.load(url: imageUrl)
    }
}
