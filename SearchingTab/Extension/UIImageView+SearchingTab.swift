//
//  UIImageView+SearchingTab.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/10.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
    func load(url: String) {
        guard let loadUrl = URL(string: url) else { return  }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: loadUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
