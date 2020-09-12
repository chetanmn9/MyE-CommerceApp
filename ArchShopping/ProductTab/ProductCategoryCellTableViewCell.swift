//
//  ProductCategoryCellTableViewCell.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 5/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit

class ProductCategoryCellTableViewCell: UITableViewCell {
    
    //Override frame
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
    
    @IBOutlet weak var productCategoryImage: UIImageView!                //Product Category Image
    @IBOutlet weak var productCategoryName: UILabel!                     //Product Category Name
    @IBOutlet weak var productCategoryDescription: UILabel!              //Product Category Description
    
    var productCategory: String = "" { didSet { updateUI()  } }
    var categoryDescription :String = "" { didSet { updateUI()  } }
    
    func updateUI() {
        productCategoryName.text = productCategory 
        productCategoryImage.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        productCategoryImage.image = UIImage(named: productCategory)
        productCategoryDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        productCategoryDescription.numberOfLines = 0
        productCategoryDescription.text = categoryDescription
    }
}
