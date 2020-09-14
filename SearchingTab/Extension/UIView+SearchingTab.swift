//
//  UIView+SearchingTab.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
