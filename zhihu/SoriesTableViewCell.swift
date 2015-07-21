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
        }
        get{
            if let text = content?.text {
                return text
            }else {
                return ""
            }
        }
    }
    
    var id: Int = 0
    var thumbUrl: NSURL? {
        set {
            let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
            dispatch_async(queue){
                if let data = NSData(contentsOfURL: newValue!) {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.thumb?.image = UIImage(data: data)
                    }
                }
            }
        }
        get { return NSURL() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            content?.textColor = UIColor.grayColor()
        }
        
    }

}
