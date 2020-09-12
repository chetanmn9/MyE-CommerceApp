//
//  ProductListTableViewCell.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 16/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import GMStepper

//protocol to implelment the +/- button to increase or decrease item quantity to be added to cart
protocol ProductListTableViewCellDelegate {
    func stepper(_ stepper: GMStepper, at index: Int, didChangeValueTo newValue: Int)
}

class ProductListTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addToCart.layer.cornerRadius = 5
        self.addToCart.clipsToBounds = true

    }
    
    //(+/-) button to increase or decrease item quantity
    @IBOutlet weak var itemQty: GMStepper!
    
    
    @IBAction func stepperValue(_ sender: Any) {
        delegate?.stepper(itemQty, at: itemQty.tag, didChangeValueTo: Int(itemQty!.value))
    }

    var delegate: ProductListTableViewCellDelegate?
    
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
            
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            
            super.frame = frame
        }
    }
     
    @IBOutlet weak var productImage: UIImageView!       //Product Image outlet
    @IBOutlet weak var productName: UILabel!            //Product Name outlet
    @IBOutlet weak var productPrice: UILabel!           //Product Price outlet
    @IBOutlet weak var priceValue: UILabel!             //Product Price Dollar sign outlet
    
    @IBOutlet weak var addToCart: UIButton!             //Product add to cart button
    
    //Method to handle add to cart action
    var cellDelegate: cellSelectDelegate?
    @IBAction func addToCart(_ sender: UIButton) {
       // let cost = (priceValue.text! as NSString).floatValue
        cellDelegate?.addToCart(sender.tag,itemQty.value,productName.text!,(priceValue.text! as NSString).floatValue)    
    }
    
}
