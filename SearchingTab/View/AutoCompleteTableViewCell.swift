//
//  AutoCompleteTableViewCell.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/11.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class AutoCompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitle(_ keyword: String) {
        self.title.text = keyword
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
