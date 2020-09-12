//
//  PressReleaseTableViewCell.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 26/5/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit

class PressReleaseTableViewCell: UITableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.90
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            
            super.frame = frame
            
        }
    }

    @IBOutlet weak var pressImage: UIImageView!
    @IBOutlet weak var pressHeadline: UILabel!
    
}
