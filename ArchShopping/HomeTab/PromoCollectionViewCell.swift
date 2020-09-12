//
//  PromoCollectionViewCell.swift
//  ArchShopping
//
//  Created by Chetan Melkote nagaraj on 15/4/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//

import UIKit
import Gemini

class PromoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!    //Promo image Outlet
    
    @IBOutlet weak var noViewing: UILabel!   //Number of Customers Viewing Outlet
    
    @IBOutlet weak var promoName: UILabel!   //Promo Name(Text) Outlet
    
    //No of Customers Viewing animations
    func countViewers (fromValue: Int, toValue: Int) {

        startValue = Double(fromValue)
        endValue = Double(toValue)
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        
        displayLink.add(to: .main, forMode: .default)
    }
    
    //Animations properties
    var startValue: Double = 0.0
    var endValue: Double = 0.0
    let animationDuration: Double = 1.5
    
    let animationStartDate = Date()
    
    fileprivate func extractedFunc(_ elapsedTime: TimeInterval) {
        let percentage = elapsedTime / animationDuration
        let value = percentage * (endValue - startValue)
        noViewing.text = String(Int(value))
    }
    
    @objc func handleUpdate() {
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            
            noViewing.text = String(Int(startValue)) //String(endValue)
            startValue += 10
            
            if startValue > endValue {
                startValue = endValue
            }
        } else {
            extractedFunc(elapsedTime)
        }
    }
}


