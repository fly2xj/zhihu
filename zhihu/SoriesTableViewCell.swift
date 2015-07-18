//
//  SoriesTableViewCell.swift
//  zhihu
//
//  Created by shawn on 15/7/18.
//  Copyright (c) 2015年 shawn. All rights reserved.
//

import UIKit

class SoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var content: UILabel!
    
    var contentText: String {
        set{
            content?.text = newValue
            thumb?.image = UIImage(named: "bg")
        }
        get{
            if let text = content?.text {
                return text
            }else {
                return ""
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
