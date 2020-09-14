//
//  HistoryTableViewCell.swift
//  SearchingTab
//
//  Created by YOUNGHEE on 2020/09/14.
//  Copyright © 2020 kakaobank. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var keyword: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeyword(_ keyword: String) {
        self.keyword.text = keyword
    }

}
